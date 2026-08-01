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
        add_score(2000,player.pos,player.depth)
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
    sfx(45)
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
		sfx(44)
		game_pu_droid=true
    elseif pu == PU_SZ_WARP then
		add(score_awards,{unpack_shape(V_EXCELLENT),player.pos,player.depth,150})
	    game_warp_powerups+=1
		add_message(game_warp_powerups==1 and S_TWO_MORE_FOR_WARP
			or game_warp_powerups==2 and S_ONE_MORE_FOR_WARP
			or S_WARP_ENABLED)
        if game_warp_powerups==3 then
            game_warp_skips=game_stage<90 and 4 or 0
            game_warp_chain=game_warp_skips>0
        end
        set_super_zap(true)
		if game_super_zap_available<0 then game_super_zap_available=0 end
    elseif pu == PU_SURPRISE then
		grant_surprise()
    else
        add_score(2000,player.pos,player.depth)
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
            self.shape = self.shapes[2]
            set_affine(self.affine)
            for i=-2,2 do
                local r = spawn_object(PART_RING,self)
                r.offset = i * 8
                r.parent = self
            end
        end
    elseif self.state == WEB then
        local dz=self.depth-player.depth

        if lane(self.pos)==lane(player.pos) and dz>=0 and dz<=self.collision then
            local e=spawn_object(EXPLOSION,self)
            e.shape,e.duration,e.end_scale=e.shapes[2],49,3
            grant_powerup(self.payload)
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
