-- player and related functions

player={}

--[[const]] player_accel=0x0.0400
--[[const]] player_maxvel=16/43
--[[const]] game_shot_limit=8
--[[const]] game_shot_cooldown=4

function set_super_zap(active)
    game_super_zap_active=active
    sfx(active and SFX_SUPERZAPPER or -1,3)
end

function kill_player(state,killer)
    if game_state!=G_ACTIVE and (game_state!=G_LEAVING or killer.type!=SPIKE) then return end
	if(game_bonus_stage)state,killer=ALIVE,player
	add_message((game_bonus_stage or state==SNATCH)and S_CAUGHT_YOU or killer.type==ESHOT and S_SHOT_YOU or S_FRIED_YOU)
    player.state=state
    player.v_pos=0
    game_killedby=killer
    set_super_zap(false)
    game_infinite_zap=false
    dead_message_timer=120
    game_state=G_DEADMESSAGE
	if state==ZAP then
		player.shape=zap_shape
	else
		player.pos=killer.pos
    end
end

function start_jump()
    if game_state==G_ACTIVE and game_pu_jump and not game_jumping then
        game_jump_v = -2
        game_jump_camera_z = camera_z
        game_jumping = true
        sfx(SFX_JUMP)
    end
end

function release_pshot(self)
    if self.droid then
        self.droid.shots=max(0,self.droid.shots-1)
    else
        game_shots_active=max(0,game_shots_active-1)
    end
end

function update_pshot(self)
    local min_speed=game_beastly and 2.25 or 4.5
    if game_pu_laser and self.zspeed<min_speed then self.zspeed=min_speed end
    self.depth+=self.zspeed
    if self.depth>160 then
        self.active=false
    else
        for o in all(world_objects) do
            if self.active and o.active and o.killable
            and (o.type!=BEAST or not o.hit)
            and lane(self.pos)==lane(o.pos)
            and abs(self.depth-o.depth)<(self.collision or 6) then
                if o.type==MIRROR then
                    o.hit=self
                    return
                elseif o.type==UFO and o.invuln then
                    o.hit = true
                    if not self.pierce then self.active=false end
                else
					if o.type==BEAST then
						o.hit=self
						if o.health>1 then self.active=false end
                    elseif not o.invuln then
                        o.hit = true
                    end

                    if o.type!=BEAST and ((not self.pierce)
                    or o.invuln and not o.beast_shot
                    or o.type==SPIKE and o.super_spike) then
                        self.active=false
                    end
                end
            end
        end
    end
    if not self.active then
        release_pshot(self)
    end
end

function update_droid(self)
    local target
    for o in all(world_objects) do
        if o.active and o.team==ENEMY and o.type!=SPIKE
        and (not target or o.depth<target.depth) then target=o end
    end
    self.wait+=1
    if self.wait>5 then
        self.shots=self.shots or 0
        if self.shots<8 then
            local s=spawn_object(PSHOT,self)
            s.droid=self
            self.shots+=1
        end
        self.wait=0
    end
    if sub_lane(self.pos)==.5 then
        if not target then return end
        self.dir=towards_pos(self.pos,target.pos,game_active_web.closed)
        if self.dir==0 then self.dir=1 end
        if not game_active_web.closed
        and (self.pos==.5 and self.dir<0
        or self.pos==num_lanes-.5 and self.dir>0) then
            self.dir=-self.dir
        end
    end
    self.pos=clamp_pos(self.pos+self.dir/16)
end
--$switch-compiler: parens8

function update_player(self)
    if game_state==G_WARP then
        update_stage_exit(self)
        return
    end
    if game_state==G_LEAVING then
        update_stage_exit(self)
        if game_state==G_WARP then return end
    end

    -- reset fire cooldown
    game_current_cooldown=max(0,game_current_cooldown-1)

    -- handle player input for movement
    if input_mouse_dx!=0 then
		self.v_pos=mid(-1,-input_mouse_dx*(mouse_opts[2]+1)/256,1)
	elseif mouse_opts[4] then
		self.v_pos=input_dir*player_maxvel*(mouse_opts[5]+1)/4
    elseif input_dir == -1 then
            if self.v_pos>0 then
                self.v_pos=0
            else
                self.v_pos=max(self.v_pos-player_accel,-player_maxvel)
            end
    elseif input_dir==1 then
        if self.v_pos<0 then
            self.v_pos=0
        else
            self.v_pos=min(self.v_pos+player_accel,player_maxvel)
        end
    else
        self.v_pos=0
    end

	if not game_bonus_stage then
    -- handle player input for shooting
    if input_fire and game_shots_active < game_shot_limit
    and game_current_cooldown <= 0 then
            spawn_object(game_pu_laser and PLASER or PSHOT,self,1)
            sfx(SFX_PLAYER_SHOT)
            game_shots_active+=1
            local cooldown=game_pu_laser and (game_beastly and 4 or 2) or (game_beastly and 8 or game_shot_cooldown)
            game_current_cooldown=cooldown
    end

    if input_super_zapper and not game_super_zap_active
    and game_super_zap_available>=0 then
        set_super_zap(true)
        if game_super_zap_available>0 then add_message(S_EAT_ELECTRIC_DEATH) end
        game_super_zap_available-=1
    end
	end

    -- update position and lane
    self.pos+=self.v_pos

    if game_jumping then
        self.depth+=game_jump_v
        game_jump_v+=0x0.0c11
        camera_z=game_jump_camera_z+self.depth
        if game_jump_v>=0 and self.depth>=0 then
            self.depth=0
            camera_z=game_jump_camera_z
            game_jump_v=0
            game_jumping=false
        end
    end

    -- update animation
    self.pos=clamp_pos(self.pos)
    local slot=8-flr(sub_lane(self.pos)*8)
    self.shape=self.shapes[slot]
    lane_effects[lane(self.pos)]=COL_YELLOW
end


function do_super_zap()
    if not game_super_zap_active then
        return
    end

    if game_world_tics%4==0 then
        local infinite=game_infinite_zap
        for o in all(world_objects) do
            if o.active and o.team==ENEMY
            and o.state!=APPROACH
            and o.type!=SPIKE and o.type!=MIRROR
            and (game_super_zap_available>=0 or o.type!=ESHOT)
            and not o.invuln then
                if o.type==BEAST then o.health=0 end
                super_zap_target=o
                o.hit=true
                -- bolt_lock suppresses drops only during the regular first zap.
                o.zapped=not infinite and game_super_zap_available>=0
                if not infinite then
                    if game_super_zap_available<0 then set_super_zap(false) end
                    return
                end
            end
        end
        set_super_zap(false)
        game_infinite_zap=false
    end
end
--$switch-compiler: none
