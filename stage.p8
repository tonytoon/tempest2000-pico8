-- stage setup and lifecycle transitions

function init_stage_environment(stage,load_web,web_id)
	init_palette(palettes[flr((stage-1)/16)+1])
	if(load_web)init_web(stage,web_id)
end
--$switch-compiler: parens8

-- yak.s slebon: n * (200n + 2600), where n is the zero-based web
function stage_select_bonus(stage)
	local n=stage-1
	return (n*200+2600)*0x0.0001*n
end

function reset_stage_threats()
	game_enemy_shots_active=0
	game_spiker_active=false
end

function reset_stage_objects(reuse_player)
	world_objects={}
	if reuse_player then
		player_objects={player}
	else
		player_objects={}
		player=spawn_object(CLAW)
	end
	player.pos=game_active_web.start-.5
end

function init_game()
	game_state=G_MENU
	game_menu=M_MAIN
	menu_x=0
	game_stage=1
	game_score=0
	game_extends_granted=1
	oneup_timer,score_awards=0,{}
	game_lives=3
	game_world_tics=0
	game_fire_rate=113
	game_flipper_pause=16
	game_fuse_cross_delay=8
	game_warp_powerups=0
	game_bonus_stage=false
	bonus_web_index=0
	game_stage_difficulty={}
	game_pu_droid_next=false
	game_yes_timer=0
	game_warp_flash=0
	game_infinite_zap=false
	game_music_playing=nil
end

function init_stage(stage,from_preview,web_id)
	set_super_zap(false)
	if game_warp_powerups>2 then game_warp_powerups=0 end
	if stage>game_stage_max then stage=1 end
	if game_beastly then
		if stage>game_beastly_high_stage then
			game_beastly_high_stage=stage
			save_settings()
		end
	else
		if stage>game_regular_high_stage then
			game_regular_high_stage=stage
			save_settings()
		end
	end
	init_stage_environment(stage,not from_preview,web_id)
	if not from_preview then
		camera_x,camera_y,camera_z,camera_cy=0,-1,web_id and camera_view_z() or -160,64
	end

	game_pu_noted=false
	game_pu_order_index=1
	game_stage_difficulty=stage_difficulty_for(stage,game_beastly)
	game_pup_delay_max=game_stage_difficulty.pup_delay_max
	game_pup_delay=0
	game_enemy_shot_limit=game_stage_difficulty.enemy_shot_limit
	game_flipper_pause=game_stage_difficulty.flipper_pause
	game_fuse_cross_delay=game_stage_difficulty.fuse_cross_delay
	reset_stage_threats()
	pulsar_deadliness=game_stage_difficulty.pulsar_deadliness
	if not from_preview then init_stage_stars(stage) end

	game_state=G_ENTER
	start_zoom(camera_view_z(),120)
	game_shots_active=0
	game_pu_laser,game_pu_droid,game_pu_jump=false,false,false
	game_super_zap_available=1
	game_infinite_zap=false
	if(stage>1)add_message(game_bonus_stage and S_WORMHOLE_DISCOVERED or S_SUPERZAPPER_RECHARGE,nil,24,nil,nil)
	game_current_cooldown=0
	game_jump_v=0
	game_jump_camera_z=camera_z
	game_jumping=false
	game_exit_speed,game_warp_speed=0,0
	game_stage_transition_complete=false

	reset_stage_objects(false)
	if from_preview then
		player.depth=camera_z-30
		player.zspeed=-player.depth/120
	end

	if not game_music_playing then
		music(0)
		game_music_playing=stage
	end
	init_wave(game_active_web.wave)
end

bonus_palettes={{141,130,2,11},{132,128,4,12},{131,3,139,14},{1,129,130,9},{131,129,5,8},{133,0,5,12},{130,128,132,11}}
bonus_webs={V_WEB5,V_WEB11,V_WEB18,V_WEB24,V_WEB27,V_WEB36,V_WEB29}

function bms(s)
	poke(12745,s*64-710)
	for i=0,4 do poke(15925+i*204,s) end
end

function init_bonus_stage()
	bonus_web_index=bonus_web_index%#bonus_webs+1
	game_bonus_target=min(game_stage+5,game_stage_max)
	game_bonus_stage=true
	init_stage(game_stage+1,nil,bonus_webs[bonus_web_index])
	bms(14)
	music(46)
	game_music_playing=nil
	local p=bonus_palettes[(game_stage-1)\16%#bonus_palettes+1]
	pal(COL_WEB1,p[1],1)
	pal(COL_WEB2,p[2],1)
	pal(COL_BLUE,p[2],1)
	pal(COL_FLIPPER,p[3],1)
	pal(COL_WEB_SPOKES,p[4],1)
	game_warp_speed,bonus_dist,game_pup_delay,bonus_powerups,bonus_slow=1,-120,32767,0,false
	game_active_web.wave.total_enemies=1
end

--[[const]] bonus_spread=72
--$switch-compiler: none
function update_bonus_stage()
	local n=bonus_dist\bonus_spread
	bonus_dist+=game_warp_speed
	if n<52 and n!=bonus_dist\bonus_spread then
		local p=spawn_object(POWERUP)
		p.depth,p.color,p.shape=216,COL_WEB_SPOKES,nil
		p.score=mid(1,rnd(10)\3,3)
		if n<32 and n%8==3 then
			p=spawn_object(PULSAR,p)
			p.state,p.lethal=WEB,nil
		end
	elseif n>=52 then
		for o in all(world_objects) do
			if(o.active and o.type==POWERUP)return
		end
		game_active_web.wave.total_enemies=0
	end
end
--$switch-compiler: parens8

function init_stage_preview()
	init_stage_environment(game_stage,true)
	game_warp_speed=0
	init_stage_stars(game_stage)
	local radius=0
	for vertex in all(game_active_web.near_verts) do
		radius=max(radius,abs(vertex[1]),abs(vertex[2]))
	end
	camera_x,camera_y,camera_z,camera_cy=0,0,30-11*radius/3,47
end

function restart_stage_after_death()
	game_lives-=1
	if game_bonus_stage then
		game_stage+=1
		game_bonus_stage=false
		game_bonus_target=nil
	end
	if game_lives>=0 then
		init_stage(game_stage)
	else
		game_lives=0
		game_over()
	end
end

function advance_warp_stage()
	game_stage_transition_complete=false
	if game_stage==game_stage_max then
		begin_finish_screen()
		return
	end
	if game_bonus_stage then
		game_stage=(bonus_slow or game_stage>89)and game_stage+1 or game_bonus_target
		game_bonus_stage=false
		game_bonus_target=nil
	elseif game_warp_powerups>2 then
		init_bonus_stage()
		return
	else
		game_stage+=1
	end
	init_stage(game_stage)
	game_warp_flash=3
end

--$switch-compiler: none

function begin_stage_exit(spike)
	game_jumping=false
	game_jump_v=0
	if game_bonus_stage then
		bonus_slow=bonus_powerups<26
		if bonus_slow then
			add_message(S_TOO_SLOW)
			oneup_timer=60
		else
			game_score+=0x0.4e20
			oneup_timer=-60
		end
	end
	game_exit_speed,game_warp_speed=0,0
	set_super_zap(false)
	game_shots_active=0
	for object in all(player_objects) do
		if object.type==PSHOT then object.active=false end
	end
	game_state=G_LEAVING
	if spike then add_message(S_AVOID_THE_SPIKES) end
end

function begin_finish_screen()
	game_complete_message=get_message(game_beastly and S_COMPLETE_BEASTLY or S_COMPLETE_REGULAR)
	complete_input=0
	if not game_beastly then
		game_beastly_unlocked=true
		game_regular_high_stage=game_stage_max
		save_settings()
	end
	game_state=G_COMPLETE
	music(-1)
	set_super_zap(false)
end

function check_for_stage_end()
	if game_state!=G_ACTIVE then return end
	if game_active_web.wave.total_enemies>0 then return end

	local spike
	for object in all(world_objects) do
		if object.active and object.type==SPIKE then spike=true end
		if not game_bonus_stage and object.active
		and object.team==ENEMY
		and object.type!=ESHOT
		and object.type!=SPIKE then
			return
		end
	end
	begin_stage_exit(spike)
end
