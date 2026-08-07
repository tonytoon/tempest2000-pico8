-- powerups and special effects
--$switch-compiler: parens8

-- fixed order for the first powerups in a game
pu_order={
    PU_LASER,
    PU_SURPRISE,
    PU_JUMP,
    PU_SURPRISE,
    PU_DROID,
    PU_SZ_WARP,
    PU_SURPRISE,
    PU_SURPRISE
}

function test_powerup(o)
    game_pup_delay -= 1
        if game_pup_delay < 0 then
            game_pup_delay = game_pup_delay_max
            local p = spawn_object(POWERUP,o)
            p.payload = pu_order[game_pu_order_index]
            
            game_pu_order_index=min(game_pu_order_index+1,#pu_order)
            
            if not game_pu_noted then
                game_pu_noted = true
                add_message(S_COLLECT_POWERUPS)
            end
        return true
    end
    return false
end

function grant_surprise()
    if rnd(256)<9 then
        game_infinite_zap=true
			set_super_zap(true)
        add_message(S_OUTTA_HERE)
        add_score(3000,player.pos,player.depth)
        game_active_web.wave.total_enemies=0
        for o in all(world_objects) do
            if o.team==ENEMY then o.active=false end
        end
    else
        add_score(2000,player.pos,player.depth,5)
    end
end

function grant_powerup(pu)
	if game_state>=G_LEAVING then
		if not game_pu_droid_next then
			game_pu_droid_next=true
			game_yes_timer=90
			messages={}
		end
		return
	end
	if game_pu_droid_next then
		pu=PU_DROID
		game_pu_droid_next=false
	end
    if pu == PU_LASER then
        game_pu_laser = true
        game_current_cooldown=min(game_current_cooldown,3)
        add_message(S_PARTICLE_LASER)
	    elseif pu == PU_JUMP then
	        add_message(S_JUMP_ENABLED)
	        game_pu_jump = true
	elseif pu == PU_DROID then
		if game_pu_droid then grant_surprise() return end
		add_message(S_AI_DROID)
		spawn_object(DROID,player,1)
		sfx(SFX_DROID)
		game_pu_droid=true
    elseif pu == PU_SZ_WARP then
		add(score_awards,{unpack_shape(V_EXCELLENT),player.pos,player.depth,150})
	    game_warp_powerups+=1
		add_message(game_warp_powerups==1 and S_TWO_MORE_FOR_WARP
			or game_warp_powerups==2 and S_ONE_MORE_FOR_WARP
			or S_WARP_ENABLED)
        set_super_zap(true)
		if game_super_zap_available<0 then game_super_zap_available=0 end
    elseif pu == PU_SURPRISE then
		grant_surprise()
    else
        add_score(2000,player.pos,player.depth,5)
    end
end

function update_pufx(self)
    if self.type==EXPLOSION then
        self.active=not update_explosion(self)
    elseif self.type==SPLATTER then
        self.duration-=1
        self.active=self.duration>0
    elseif self.type==PART_RING then
        if not self.parent or not self.parent.active then
            self.active=false
        else
            self.depth=self.parent.depth+self.offset
            self.pos=self.parent.pos
        end
    elseif self.state == SPAWN then
        if update_explosion(self) then
            self.state = WEB
            set_affine(self.affine)
            for i=-2,2 do
                local r = spawn_object(PART_RING,self)
				r.offset,r.parent,r.color=i*8,self,self.color
            end
        end
    elseif self.state == WEB then
        local dz=self.depth-player.depth

		if lane(self.pos)==lane(player.pos) and dz>=0 and dz<=self.collision then
			local e=spawn_object(EXPLOSION,self)
			e.color,e.duration,e.end_scale=COL_CYCLE_COOL,49,3
			sfx(SFX_POWERUP)
			if game_bonus_stage then
				bonus_powerups+=1
				add_message(S_SPEED_UP)
				messages[1][3]=40
				game_warp_speed+=game_warp_speed/64
				add_score(self.score*250,self.pos,self.depth,self.score)
				if(bonus_powerups==13)bms(12)
				if(bonus_powerups==26)begin_stage_exit()
			else
				grant_powerup(self.payload)
			end
			self.active=false
        elseif approach_edge(self) then
            self.active=false
        end
    end
end
--$switch-compiler: none

function update_explosion(self)
	self.wait+=1
    self.angle+=self.rot_speed
	set_affine(
		self.affine,
		lerp(self.start_scale,self.end_scale,self.wait/self.duration),
		self.angle
	)
	return self.wait>=self.duration
end

function draw_particle_ring(m,n,r,c)
	for i=0,n-1 do
		local a=i/n
		local x,y=r*cos(a),r*sin(a)
		pset(x*m[1]+y*m[2]+m[3],x*m[4]+y*m[5]+m[6],c)
	end
end

function draw_explosion(o,m)
	if o.type==PART_RING then
		draw_particle_ring(m,12,10,o.color)
		return
	end
	local tanker=o.tanker_explosion
	-- yak.s draw_prex/pring2: three rings, doubling radius and two fewer pixels per ring
	local r,n=tanker and 26 or 32,16
	for ring=1,3 do
		local c=tanker and (ring==1 and COL_WHITE
			or ring==2 and COL_YELLOW or COL_CYCLE_HOT) or o.color
		draw_particle_ring(m,n,r,c)
		r*=2
		n-=2
	end
end
