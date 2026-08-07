
pulsar_anim={
	1,1,1,2,3,4,5,6,
	6,5,4,3,2,1,1,1
}

pulsar_deadliness=9

-- i would normally make extensive use of callbacks and a more nuanced update loop
-- but crammed as much as i could into a big update loop to reduce token use
--$switch-compiler: parens8
function update_enemy(self)
	-- update animations
	if self.type==SPIKE then
		self.depth=160-self.health
		if self.state==DEAD then
			spawn_object(EXPLOSION,self)
			sfx(SFX_EXPLOSION)
			self.active=false
		end
		return
	elseif self.type==BEAST and self.health>0 then
		self.shape=self.shapes[self.health]
	elseif self.type==PULSAR or self.type==SPARK then
		self.shape=self.shapes[pulsar_frame]
		if self.type==PULSAR then self.cross+=1 end
	elseif self.type==FUSEBALL and game_world_tics%4==0 then
		self.shape=self.shapes[flr(rnd(2))+1]
	end

	if self.type==UFO and self.state!=APPROACH then
		update_ufo(self)
		return
	end

	if self.state==APPROACH then
		self.depth-=2
		if self.depth<=160 then
			self.depth=160
			if self.type==PULSAR then
				if self.cross\pulsar_deadliness%16<3 then
					self.state=WEB
				end
			elseif self.type==SPIKER then
				self.state=WEB
			elseif self.type==UFO then
				self.state=WEB
				self.invuln=true
			elseif self.super_run then
				self.state=EDGE
			else
				self.state=WEB
			end
		end

	elseif self.state==WEB then
		try_shot(self)

		if self.type==FLIPPER or self.type==SFLIPPER2
		or self.type==SFLIPPER3 or self.type==BEAST
		or self.type==TANKER or self.type==FUTANKER
		or self.type==PUTANKER or self.type==PULSAR then
			if self.type==PULSAR then
				local phase=self.cross\pulsar_deadliness%16
				local zap=phase>=5 and phase<=9
				self.zap=game_bonus_stage and zap
				lane_effects[lane(self.pos)]=zap and COL_CYCLE_COOL or COL_WHITE
				if zap and phase==7 and lane(player.pos)==lane(self.pos) then
					kill_player(ZAP,self)
				end
			end
			if not game_bonus_stage and approach_edge(self) then
				self.state=EDGE
			end

		elseif self.type==SPIKER then
			local i=lane(self.pos)
			local s=spikes[i]
			if not s then
				s=spawn_object(SPIKE,self)
				spikes[i]=s
			end
			if approach_edge(self,10) then
				self.state=DESCEND
			elseif 160-self.depth>s.health then
				s.health=min(150,s.health+self.zspeed)
				self.build-=1
				if self.build<0 then self.state=DESCEND end
			end

		elseif self.type==FUSEBALL then
			self.wait+=1
			local delay=max(1,self.cross_delay or game_fuse_cross_delay or 49)
			if self.wait>=delay then
				self.wait=0
				self.state=CROSS
				self.dir=towards_pos(
					self.pos,
					player.pos,
					game_active_web.closed
				)
			else
				approach_edge(self)
			end

		elseif self.type==MIRROR then
			approach_edge(self,40)

		elseif self.type==ESHOT then
			approach_edge(self)
			if game_state==G_ACTIVE and hit_player(self) then
				kill_player(ZAP,self)
			elseif self.depth>0 then
				return
			end
			release_eshot(self)
			self.active=false
			if self.reflected then release_pshot(self) end
		end

	elseif self.state==EDGE then
		if self.type==FLIPPER or self.type==SFLIPPER2
		or self.type==SFLIPPER3 or self.type==BEAST then
			if self.tanker_child==2 then
				self.tanker_child=nil
			else
				if hit_player(self) and self.lethal then
					kill_player(SNATCH,self)
				end
				if not game_beastly then
					self.wait+=1
					if self.wait<self.flip_wait then return end
				end
			end
			self.wait=0
			self.state=FLIP

		elseif self.type==PULSAR then
			local a,b=spawn_object(SPARK,self),spawn_object(SPARK,self)
			a.dir,b.dir=-1,1
			self.active=false

		elseif self.type==TANKER or self.type==FUTANKER
		or self.type==PUTANKER then
			tanker_spawn(self)
			sfx(SFX_EXPLOSION)
			self.active=false

		elseif self.type==SPARK then
			if hit_player(self) then
				kill_player(ZAP,self)
			end
			self.wait+=1
			if self.wait>=5 then
				self.wait=0
				if not game_active_web.closed
				and (self.pos+self.dir<0
				or self.pos+self.dir>=num_lanes) then
					self.dir=-self.dir
				end
				self.pos+=self.dir
			end
		end

	elseif self.state==CROSS then
		if self.type==FUSEBALL and self.depth<=0 and hit_player(self) then
			kill_player(ZAP,self)
			return
		end
		self.cross+=1
		self.pos+=self.dir/32
		self.killable=self.type!=FUSEBALL
			or self.cross>=6 and self.cross<=23
		if self.cross>=32 then
			self.cross=0
			self.state=WEB
			if self.type==FUSEBALL then self.killable=false end
		end

	elseif self.state==DESCEND then
		try_shot(self)
		self.depth+=self.zspeed
		if self.depth>=160 then
			self.depth=160
			spiker_find_lane(self)
			self.state=WEB
		end

	elseif self.state==FLIP then
		if self.super_run then
			self.depth=max(0,self.depth-self.zspeed)
			if self.depth==0 then self.super_run=nil end
		end
		if flipper_flip(self) then
			self.state=self.super_run and EDGE or WEB
			return
		end
		if self.flip_lane==lane(player.pos)
		and abs(self.depth-player.depth)<=2 and self.lethal then
			kill_player(SNATCH,self)
		end
    end
end

function update_ufo(self)
    if self.depth>-15 then
        self.depth=max(-15,self.depth-self.zspeed*2)
        if self.depth==-15 then self.invuln=nil end
    elseif self.cross==0 then
        self.dir=self.dir or (rnd()<.5 and -1 or 1)
        if not game_active_web.closed
        and (self.pos+self.dir<0 or self.pos+self.dir>num_lanes) then
            self.dir=-self.dir
        end
        self.cross=1
    elseif self.cross<49 then
        self.pos+=self.dir/48
        self.cross+=1
    else
		lane_effects[lane(self.pos)]=COL_WHITE
        if lane(self.pos)==lane(player.pos) and player.depth>=0 then
            kill_player(ZAP,self)
        end
        self.cross=(self.cross+1)%81
    end
end
--$switch-compiler: none

function bonus_score()return 250+flr(rnd(3))*250 end

--$switch-compiler: parens8
function resolve_enemy_hit(self)
	local tanker=self.type==TANKER
		or self.type==FUTANKER
		or self.type==PUTANKER

    if self.type==MIRROR then
        local shot=self.hit
        self.hit=false
        self.health-=1
        self.depth+=self.zspeed*16
        if self.health>0 and self.depth<=160 then
            shot.type=ESHOT
            shot.shape=spawn_data[MIRROR].ref_shape
            shot.reflected=true
            shot.team=nil
            shot.rot=nil
            move_to_world_objects(shot)
            sfx(SFX_FLIP)
            return
        end
        self.hit=true
    elseif self.type==UFO then
        if self.invuln then
            self.depth+=self.zspeed*32
            spawn_object(SPLATTER,self)
            self.hit=self.depth>=160
            if not self.hit then return end
        end
    elseif tanker then
        tanker_spawn(self)
    elseif self.type==SPIKE then
		add_score(self.score,self.pos,self.depth)
        self.health-=3
        if self.health>=0 then
            self.hit=false
            spawn_object(SPLATTER,self)
            if self.health>96 then
                sfx(SFX_SPIKE_HIGH)
            elseif self.health>48 then
                sfx(SFX_SPIKE_MID)
            else
                sfx(SFX_SPIKE_LOW)
            end
        else
            spikes[lane(self.pos)]=nil
        end
    elseif self.type==BEAST then
        local shot=self.hit
        self.health-=1
        if self.health>0 then
            local b=spawn_object(BSHOT,self)
            b.zspeed=shot.zspeed/2
            b.shape=b.shapes[self.health]
            b.beast_shot=true
            self.hit=false
        end
    end

	local drops_powerup=
		self.type==FLIPPER or self.type==TANKER
		or self.type==SPIKER or self.type==PULSAR
		or self.type==FUTANKER or self.type==PUTANKER
		or self.type==SFLIPPER2 or self.type==BEAST
		or self.type==SFLIPPER3 or self.type==ESHOT
		or self.type==SPIKE or self.type==SPARK
	local pup=drops_powerup and self.hit
		and not self.zapped and test_powerup(self)
	self.zapped=nil
	if self.hit then
		if self.type==SPIKER then game_spiker_active=false end
		if self.type==ESHOT then release_eshot(self) end
		self.active=false
		local score=self.score
		local q=type(score)=="function"and score()
		add_score(q or score or 0,self.pos,self.depth,q and q\250)
		if not pup then
			local e=spawn_object(EXPLOSION,self)
			if tanker then e.tanker_explosion,e.duration,e.end_scale=true,20,2 end
		end
		sfx(SFX_EXPLOSION)
	end
end
--$switch-compiler: none

function hit_player(self)
    return lane(self.pos)==lane(player.pos)
    and abs(self.depth-player.depth)<=2
end

function approach_edge(self, distance)
    distance = distance or 0
	self.depth-=game_bonus_stage and game_warp_speed or self.zspeed
	if self.depth<=distance then
		self.depth=distance
		return true
	end
end

function tanker_spawn(self)
    local t=self.type==TANKER and FLIPPER or self.type==FUTANKER and FUSEBALL or PULSAR
    local a,b=spawn_object(t,self),spawn_object(t,self)
    a.state=t==FUSEBALL and CROSS or FLIP
    b.state=a.state
    a.dir,b.dir=-1,1
    if t!=FUSEBALL then
        a.tanker_child=1
        b.tanker_child=1
        if t==FLIPPER then
            superflip(a,1)
            superflip(b,-1)
        end
    end
end

function superflip(o,dir)
    if rnd(256)>=tanker_superflip_chance(game_stage) then return end
	o.type=SFLIPPER2
	o.flip_wait=0
	o.shoots=true
	o.scarper=(flr(rnd(4))+1)*dir
	if rnd(256)<superflipper3_chance(game_stage) then o.type=SFLIPPER3 end
	o.shape=spawn_data[o.type].shape
end

function flipper_flip(self)
    -- flipper flipping animation. as we rotate it, we also apply a translation
    -- so that it looks like it's "tumbling" along its edge
    if self.flip_frame==0 then
        self.dir=self.dir
			or towards_pos(self.pos,player.pos,game_active_web.closed)
        if self.super_run then self.dir=-self.dir end
        self.flip_lane,self.web_flip=lane(self.pos),self.depth>0
    end

    self.flip_frame+=1
    local frames=self.type==SFLIPPER2 and 16 or 32
    local fd=self.web_flip and -1 or 1

    set_affine(scratch_mat,1,self.dir*fd/frames/2)

    -- keep rotation cumulative so orientation persists across EDGE transitions
    mul_affine(self.affine,self.affine,scratch_mat)

    -- translation is absolute per-frame to avoid cumulative drift
    self.affine[3],self.affine[6]=
		0,fd*12*(1-abs(self.flip_frame/frames*2-1))

    self.pos+=self.dir/frames

    local past_peak=self.flip_frame>frames*.6
    self.lethal,self.killable=not past_peak and not self.tanker_child,past_peak
    if self.flip_frame<frames then return end
    sfx(SFX_FLIP)
    self.flip_frame,self.dir,self.flip_lane,self.lethal,self.killable=0,false,nil,true,true
	-- scarper is a real word used in britain that means to run away or flee
	-- used in the jaguar source so i kept it because i like it
    if self.scarper and self.scarper!=0 then
        self.dir=sgn(self.scarper)
        self.scarper-=self.dir
        return
    end
    if self.tanker_child then self.tanker_child=2 end
    return true
end

function try_shot(self)
    if not self.shoots then return end
    game_fire_rate-=1
    if game_fire_rate>0 then return end
    local base=game_active_web.fire_rate or 113
    game_fire_rate=game_beastly and max(1,flr(base*0.6)) or base
    if game_state!=G_ACTIVE or self.depth<=60
    or game_enemy_shots_active>=game_enemy_shot_limit then return end
    local shot=spawn_object(ESHOT,self)
    shot.enemy_shot=true
    game_enemy_shots_active+=1
end

function release_eshot(self)
    if self.enemy_shot then
        self.enemy_shot=false
        game_enemy_shots_active=max(0,game_enemy_shots_active-1)
    end
end

function spiker_find_lane(self)
	local min,candidates=32767,{}

	for i=1,num_lanes do
		local s=spikes[i] and spikes[i].health or 0

        if s < min then
            min = s
            candidates = {i}
        elseif s == min then
            add(candidates, i)
        end
	end
	self.pos=rnd(candidates)-.5
	self.build=50
end

function random_lane(avoid_edges)
    local lane = flr(rnd(num_lanes))+1
    if avoid_edges and not game_active_web.closed and (lane == 1 or lane == num_lanes) then
        return random_lane(avoid_edges)
    end
    return lane
end

function draw_spike(self)
	local i,t=lane(self.pos),sub_lane(self.pos)
	local v=game_active_web.near_verts
	local a,b=v[i],v[i%#v+1]
	local x,y=lerp(a[1],b[1],t),lerp(a[2],b[2],t)
	draw_world_line(x,y,web_near_z+self.depth,x,y,web_far_z,
		self.super_spike and COL_CYCLE_HOT or COL_GREEN)
end
