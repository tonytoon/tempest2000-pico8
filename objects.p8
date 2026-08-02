-- object definitions and manager

-- sort objects by depth
function add_objects_to_draw_list(draw_objects,objects)
    for o in all(objects) do
        local i=1
        while i<=#draw_objects and draw_objects[i].depth>o.depth do
            i+=1
        end
        add(draw_objects,o,i)
    end
end

function build_draw_list()
    local draw_objects={}
    add_objects_to_draw_list(draw_objects,player_objects)
    add_objects_to_draw_list(draw_objects,world_objects)
    for o in all(draw_objects) do
		draw_object(o)
	end
end

function draw_object(o)
	if o.type==CLAW and game_state==G_WARP and game_warp_chain then return end
	if o.type==SPIKE then draw_spike(o) return end
	local s=o.type==PUTANKER and spawn_data[PUTANKER].shape or o.shape
	if not s then return end
	local p=o.type==CLAW and snap_pos(o.pos) or o.pos
	local x,y,z=project(p,o.depth)

	if not x then return end
	if o.state==APPROACH then
		apset(x,y,s.cmds[1][2])
		return
	end

	local ds=object_world_scale*camera_world_scale*camera_focal/z
	set_affine(scratch_mat,ds,0,x,y)

	mul_affine(scratch_mat,scratch_mat,game_active_web.shape.normals[lane(p)])
	mul_affine(scratch_mat,scratch_mat,o.affine)

	if o.type==UFO and o.cross>=49 then
		draw_zap(o.pos,o.depth,o.pos,160)
	end

	--local fade=o.type==CLAW and game_state==G_ENTER and o.depth<0
	--if(fade)fillp(~(0xffff<<min(16,-o.depth/5)),true)
	if o.type==BEAST then
		-- draw horns first so neither horn's root wins the overlap
		for i=2,o.health do gpu_draw(o.shapes[i],scratch_mat) end
		gpu_draw(o.shapes[1],scratch_mat)
	else
	    gpu_draw(s,scratch_mat)
	end
	--if(fade)fillp()
end

--
-- creation and update logic for objects
--
--$switch-compiler: parens8

function apply_enemy_speed(o)
    o.zspeed=enemy_zspeed_for_stage(o.type,game_stage) or o.zspeed
    if game_beastly and (o.type==PSHOT or o.type==PLASER or o.type==ESHOT or o.type==BSHOT) then
        o.zspeed=o.zspeed/2
    end
    if o.type==FUSEBALL then
        o.cross_delay=game_fuse_cross_delay
    elseif (o.type==FLIPPER or o.type==BEAST) and not game_beastly then
        o.flip_wait=game_flipper_pause
    elseif (o.type==SFLIPPER2 or o.type==SFLIPPER3) then
        o.flip_wait=0
    end
end

-- spawn functions
function spawn_object(type, parent, snap)
    local o = {}

    -- regular wave flippers can mutate into level-2 super flippers
    if type==FLIPPER and (not parent or parent.type!=TANKER)
    and rnd(256)<wave_superflipper_chance(game_stage) then
        type=SFLIPPER2
    end
    
    local data = spawn_data[type]

    for k,v in pairs(data) do o[k]=v end

    o.affine = {1,0,0, 0,1,0}
    if parent then
        o.pos = parent.pos
        o.depth = parent.depth
    else
        local avoid_edges=type==TANKER or type==FUTANKER or type==PUTANKER
        o.pos = snap_pos(random_lane(avoid_edges) - 1)
    end

    if snap then
        o.pos = snap_pos(o.pos)
    end

    apply_enemy_speed(o)

    o.lethal=o.team==ENEMY
    o.killable=o.lethal
    if type==FUSEBALL then o.killable=false end
    if type==SPIKER then
        game_spiker_active=true
        spiker_find_lane(o)
    end
    if type==SPIKE then
        o.super_spike=rnd(256)<super_spike_chance(game_stage)
    end

    add(o.team==PLAYER and player_objects or world_objects,o)
    return o
end

--$switch-compiler: none

function finish_object_updates(objects)
    for o in all(objects) do
        if o.active and o.rot then
            set_affine(scratch_mat,1,o.rot)
            mul_affine(o.affine,o.affine,scratch_mat)
        elseif not o.active then
            del(objects,o)
        end
    end
end

function move_to_world_objects(o)
    del(player_objects,o)
    add(world_objects,o)
end

-- update functions
--$switch-compiler: parens8

function update_stage_exit(self)
    if game_state==G_LEAVING then
        self.depth += game_exit_speed
        camera_z += game_exit_speed
        game_exit_speed += 0x0.0400

        if self.depth >= 160 then
            self.depth = 160
            game_warp_speed = game_warp_chain and 4 or 0
            game_state = G_WARP
        end
    elseif game_state==G_WARP then
        self.depth += game_exit_speed+game_warp_speed
        camera_z += game_exit_speed
        game_exit_speed += 0x0.0400
        game_warp_speed += 0x0.1000

        local target=game_warp_chain and 600 or 2000
        if self.depth >= target then
            self.depth = target
            game_stage_transition_complete = true
        end
    end
end

-- object definitions are generated from data/object_defs.txt

spawn_data={}

function init_spawn_data()
	local a=PTR_OBJECT_DEFS_DATA
	local object_count=@a
	local curve_base=a+2
	a=curve_base+@(a+1)*50
	spawn_data={}
	enemy_zspeeds={}

	for i=1,object_count do
		a+=1
		local object_type=@a
		local curve=@(a+1)
		local shape_count=@(a+2)
		a+=3
		local definition={}
		if object_type!=ENEMY then
			for key,value in pairs(spawn_data[ENEMY]) do definition[key]=value end
			definition.type=object_type
		end
		if curve>0 then
			enemy_zspeeds[object_type]=curve_base+(curve-1)*50
		end
		if shape_count>0 then
			definition.shapes={}
			for j=1,shape_count do
				add(definition.shapes,unpack_shape(@a))
				a+=1
			end
			definition.shape=definition.shapes[1]
		end

		local attribute_count=@a
		a+=1
		for j=1,attribute_count do
			local field=@a
			a+=1
			local value
			if field>=128 then
				field-=128
				value=bonus_score
			elseif field>=64 then
				field-=64
				value=-(@a|(@(a+1)<<8))*0x0.0001
				a+=2
			elseif field>=32 then
				field-=32
				value=true
			else
				value=@a|(@(a+1)<<8)
				a+=2
				if field==6 then
					value/=128
				elseif field==11 or field==21 or field==22 then
					value*=0x0.0001
				elseif field==19 or field==20 then
					value/=256
				end
			end

			if field==1 then definition.type=value
			elseif field==2 then definition.state=value
			elseif field==3 then definition.team=value
			elseif field==4 then definition.active=value
			elseif field==5 then definition.depth=value
			elseif field==6 then definition.zspeed=value
			elseif field==7 then definition.wait=value
			elseif field==8 then definition.cross=value
			elseif field==9 then definition.flip_frame=value
			elseif field==10 then definition.v_pos=value
			elseif field==11 then definition.rot=value
			elseif field==12 then definition.pierce=value
			elseif field==13 then definition.collision=value
			elseif field==14 then definition.invuln=value
			elseif field==15 then definition.flip_wait=value
			elseif field==16 then definition.shoots=value
			elseif field==17 then definition.health=value
			elseif field==18 then definition.duration=value
			elseif field==19 then definition.start_scale=value
			elseif field==20 then definition.end_scale=value
			elseif field==21 then definition.rot_speed=value
			elseif field==22 then definition.angle=value
			elseif field==23 then definition.super_run=value
			elseif field==24 then definition.score=value
			elseif field==25 then definition.color=value
			end
		end
		spawn_data[object_type]=definition
	end
end
--$switch-compiler: none
