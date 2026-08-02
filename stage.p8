-- stage setup and lifecycle transitions

function init_stage_environment(stage,load_web)
	init_palette(palettes[flr((stage-1)/16)+1])
	if(load_web)init_web(stage)
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
	game_warp_skips=0
	game_warp_chain=false
	game_stage_difficulty={}
	game_jump_help=false
	game_pu_droid_next=false
	game_yes_timer=0
	game_warp_flash=0
	game_infinite_zap=false
	game_music_playing=nil
end

function init_stage(stage,from_preview)
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
	init_stage_environment(stage,not from_preview)
	if not from_preview then
		camera_x,camera_y,camera_z,camera_cy=0,-1,-160,64
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
	if stage>1 then add_message(S_SUPERZAPPER_RECHARGE) end
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

	msgtimer=240
	newtrack=false
	if not game_music_playing then
		music(0)
		newtrack=true
		game_music_playing=stage
	end
	init_wave(game_active_web.wave)
end

function init_warp_stage(stage)
	init_stage_environment(stage,true)
	reset_stage_objects(true)
	player.depth=160
	player.v_pos=0
	camera_x,camera_y,camera_z=0,-1,-23
	reset_stage_threats()
	lane_effects={}
end

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
		game_over()
		return
	end
	game_stage+=1
	if game_warp_chain and game_warp_skips>0 then
		game_warp_skips-=1
		init_warp_stage(game_stage)
	else
		if game_warp_chain then
			game_warp_chain=false
			game_warp_powerups=0
		end
		init_stage(game_stage)
		game_warp_flash=3
	end
end

--$switch-compiler: none

function begin_stage_exit(spike)
	game_jumping=false
	game_jump_v=0
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
	local message=get_message(game_beastly and S_COMPLETE_BEASTLY or S_COMPLETE_REGULAR)
	game_complete_message=message[1]
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
		if object.active
		and object.lethal
		and object.type!=ESHOT
		and object.type!=SPIKE then
			return
		end
	end
	if game_stage==99 then
		begin_finish_screen()
		return
	end
	begin_stage_exit(spike)
end
