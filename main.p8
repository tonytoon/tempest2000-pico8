pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
--[tempest 2000 0.9.2]
--by [deepthaw]
--[[const]] game_stage_max=99
#include enums.p8
#include difficulty.p8
#include colors.p8
#include packed_data.p8
#include gpu.p8
#include camera.p8
#include math.p8
#include input.p8
#include objects.p8
#include enemy.p8
#include pufx.p8
#include player.p8
#include stars.p8
#include unpack.p8
#include shapes.p8
#include waves.p8
#include webs.p8
#include stage.p8
#include logo.p8

-- enabled,sensitivity,max lanes,jump. the numbers are indexes to save tokens:
-- sensitivity/max=(value+1)/4 and jump=value*10 (0 means off)
mouse_opts={false,3,9,0}
crt_adjust=false
menu_selection=1
reset_confirm=false
game_regular_high_stage=1
game_beastly_high_stage=1

-- initialization-only code stays native to avoid bytecode wrapper overhead
function init_scores()
	cartdata("tempest2000v092")
	hs,hsn={},{}
	for i=0,4 do add(hs,dget(i)) end
	for i=7,46 do add(hsn,dget(i)) end
	if hs[5]==0 then
		reset_data()
	end
	p=dget(5)
	game_regular_high_stage=mid(1,p&127,game_stage_max)
	game_beastly_unlocked=p>=128
	p=dget(6)
	if p>0 then
		mouse_opts={(p&1)>0,p>>1&15,p>>5&15,p>>9&7}
		crt_adjust=(p&0x1000)>0
		game_beastly_high_stage=mid(1,p>>13,game_stage_max)
	end
	if game_beastly_unlocked then
		game_regular_high_stage=game_stage_max
	end
	set_crt_adjust()
end

function save_data()
	for i=1,5 do dset(i-1,hs[i]) end
	for i=1,40 do dset(i+6,hsn[i]) end
	save_settings()
end

function crt_menu()
	menuitem(1,"crt adjust:"..(crt_adjust and"on"or"off"),function()
		crt_adjust=not crt_adjust
		set_crt_adjust()
		save_settings()
		crt_menu()
		return true
	end)
end

function save_settings()
	dset(5,game_regular_high_stage|(game_beastly_unlocked and 128 or 0))
	dset(6,(mouse_opts[1] and 1 or 0)
		|mouse_opts[2]<<1
		|mouse_opts[3]<<5
		|mouse_opts[4]<<9
		|(crt_adjust and 0x1000 or 0)
		|(game_beastly_high_stage<<13))end

function reset_data()
	game_regular_high_stage=1
	game_beastly_high_stage=1
	game_beastly_unlocked=false
	mouse_opts={false,3,9,0}
	crt_adjust=false
	set_crt_adjust()
	display_aspect_x=1
	display_aspect_y=1
	hs={
		0xa.6040, -- 680000
		0x7.d000, -- 512000
		0x6.68a0, -- 420000
		0x4.caf4, -- 314100
		0x0.c350  -- 50000
	}
	hsn={}
	for name in all(split("YAK,DAVE,ZAPHOD,LISTER,JOOLS")) do
		for i=1,8 do add(hsn,i<=#name and ord(name,i)-64 or 0) end
	end
	save_data()
end

function game_over()
	game_state=G_GAMEOVER
	music(-1)
	set_super_zap(false)
	for i=1,5 do
		if game_score>hs[i] then
			add(hs,game_score,i) deli(hs,6)
			for j=40,i*8+1,-1 do hsn[j]=hsn[j-8] end
			for j=1,8 do hsn[(i-1)*8+j]=0 end
			hs_pos,hs_char=i,1
			return
		end
	end
end

function unlock_beastly_from_high_score_name()
	local name=""
	local start=(hs_pos-1)*8+1
	for i=0,7 do
		local n=hsn[start+i]
		if n<=0 then break end
		name..=chr(64+n)
	end
	if name=="KRYTEN" then
		game_beastly_unlocked=true
		game_regular_high_stage=game_stage_max
	elseif name=="RIMMER" then
		game_regular_high_stage=game_stage_max
	elseif name=="HOLLY" then
		game_beastly_unlocked=true
		game_regular_high_stage=game_stage_max
		game_beastly_high_stage=game_stage_max
	end
end

messages = {}
--$switch-compiler: none
function add_message(msg)
	msg=get_message(msg)
	msg[3]+=msg[4]
	messages={msg}
end

function add_score(s,p,d)
	if game_beastly then s*=2 end
	game_score+=s*0x0.0001
	local q=score_shapes[s==2000 and 5 or s\250]
	if q then add(score_awards,{q,p,d,150}) end
end

function show_messages()
	for m in all(messages) do
		m[3]-=1
		if m[3]<=0 then
			del(messages,m)
		end
		local y,a=m[2]+32,split(m[5],"|")
		local z=120/(5*#a[1]-1)
		local k=z*(abs((game_world_tics*2)%256-127)-63)/128
		local sy=z*min(1,m[3]/20)
		y-=4*z*(#a-1)
		for s in all(a) do
			local x=64-(5*#s-1)*z/2
			gpu_text(s,x,y,z,sy,nil,k)
			y+=8*z
		end
	end
end

function draw_hud()
	if game_yes_timer>0 then
		local t=90-game_yes_timer
		if t%30<21 then
		local s=(t\30+1)*128/66
			set_affine(scratch_mat,s,0,64,64)
			gpu_draw(yes_shape,scratch_mat)
		end
		game_yes_timer-=1
	end

	print("score:"..tostr(game_score,2),1,1+adjust_y,COL_GREY)
	print("score:"..tostr(game_score,2),0,0+adjust_y,COL_WHITE)

	local wc = game_warp_powerups >= 3 and COL_CYCLE_HOT or COL_GREEN
	print("warp:",1,9+adjust_y,COL_GREY)
	local x = print("warp:",0,8+adjust_y,COL_WHITE)
	for i=1,game_warp_powerups do
		x=print(chr(143),x,8+adjust_y,wc)
	end

	print("lives:"..game_lives,97,1+adjust_y,COL_GREY)
	print("lives:"..game_lives,96,0+adjust_y,COL_WHITE)

	print('stage:'..game_stage,96,8+adjust_y,COL_WHITE)
	show_messages()
end

lane_effects = {}

function _init()
	init_palette(palettes[1])
	init_packed_data()
	init_spawn_data()
	init_shapes()
	init_tempest_logo()
	init_scores()
	game_beastly=false
	init_game()
	crt_menu()
	poke(0x5f2d,mouse_opts[1] and 5 or 0)
end
--$switch-compiler: parens8

function update_menu_state(accept)
	if game_menu==M_STAGE_SELECT then update_stars() end
	if data_scores then
		if accept or btnp(5) then data_scores=false end
		return
	end
	if reset_confirm then
		if accept then
			reset_data()
			poke(0x5f2d,0)
			reset_confirm=false
		elseif btnp(5) then
			reset_confirm=false
		end
		return
	end

	if menu_target then
		menu_x+=menu_step
		if abs(menu_x)>=128 then
			if menu_target==0 then
				menu_x=0
				game_score+=stage_select_bonus(game_stage)
				game_extends_granted=game_score/0x0.4e20\1+1
				init_stage(game_stage,true)
			else
				game_menu=menu_target
				menu_x=-menu_x
				menu_selection=1
				if game_menu==M_STAGE_SELECT then
					init_stage_preview()
				elseif game_menu==M_MAIN then
					init_palette(palettes[1])
					camera_cy=64
				end
			end
			menu_target=nil
		end
		return
	elseif menu_x!=0 then
		menu_x=approach(menu_x,0,16)
		return
	end

	menu_move(accept)

	if btnp(5) and game_menu!=M_MAIN then
		menu_target=M_MAIN
		menu_step=16
	elseif accept then
		menu_accept()
	end
end

function menu_items()
	if game_menu==M_MAIN then
		return game_beastly_unlocked and "start game,beastly game,options,data"
			or "start game,options,data"
	elseif game_menu==M_OPTIONS then
		return "mouse,sensitivity,max lanes,jump,crt adjust"
	elseif game_menu==M_DATA then
		return "high scores,reset data"
	end
	return "stage: "..game_stage.."  bonus: "..tostr(stage_select_bonus(game_stage),2)..",up/down: stage +/- 1,left/right: stage +/- 10"
end

function menu_y()
	return game_menu==M_MAIN and 84 or game_menu==M_STAGE_SELECT and 88 or 72
end

function menu_move(accept)
	if game_menu==M_STAGE_SELECT then
		local d=btnp(2) and 1 or btnp(3) and -1
			or btnp(0) and -10 or btnp(1) and 10 or 0
		game_stage=mid(1,game_stage+d,(game_beastly and game_beastly_high_stage or (game_beastly_unlocked and game_stage_max or game_regular_high_stage)))
		if d!=0 then init_stage_preview() end
		return
	end
	if game_menu==M_OPTIONS then
		if btnp(2) or btnp(3) then
			menu_selection=(menu_selection+(btnp(3) and 0 or -2))%5+1
			if not mouse_opts[1] and menu_selection>1 and menu_selection<5 then
				menu_selection=btnp(3) and 5 or 1
			end
			return
		end
		if btnp(0) or btnp(1) or accept then
			local d=btnp(0) and -1 or 1
			if menu_selection==1 then
				mouse_opts[1]=not mouse_opts[1]
				poke(0x5f2d,mouse_opts[1] and 5 or 0)
			elseif menu_selection==5 then
				crt_adjust=not crt_adjust
				set_crt_adjust()
				crt_menu()
			else
				local i=menu_selection
				mouse_opts[i]=(mouse_opts[i]+d)%(i<4 and 16 or 6)
			end
			save_settings()
		end
		return
	end
	if btnp(2) or btnp(3) then
		local n=game_menu==M_MAIN and (game_beastly_unlocked and 4 or 3) or game_menu==M_DATA and 2 or 4
		menu_selection=(menu_selection+(btnp(3) and 0 or -2))%n+1
	end
end

function menu_accept()
	if game_menu==M_DATA and menu_selection==2 then
		reset_confirm=true
		return true
	end
	menu_step=-16
	if game_menu==M_MAIN then
		local b=game_beastly_unlocked and 1 or 0
		game_beastly=menu_selection==2
		menu_target=menu_selection<=1+b and M_STAGE_SELECT
			or menu_selection==2+b and M_OPTIONS or M_DATA
	elseif game_menu==M_STAGE_SELECT then
		menu_target=0
	elseif game_menu==M_DATA then
		data_scores=true
	end
	return false
end

--$switch-compiler: none
function update_dead_message_state()
	dead_message_timer-=1
	if player.state==ZAP then
		camera_z-=1
		set_affine(
			player.affine,
			16-dead_message_timer/8,
			dead_message_timer*.046875
		)
	elseif player.depth<160 then
		player.depth+=2.25
		game_killedby.depth=player.depth
	else
		camera_z-=8
	end

	if dead_message_timer<=0 then
		restart_stage_after_death()
	end
end
--$switch-compiler: parens8
function update_game_over_state()
	if hs_pos then
		local d=btnp(2) and -1 or btnp(3) and 1
		if d then
			local k=(hs_pos-1)*8+hs_char
			hsn[k]=(hsn[k]+d)%27
		end
		if btnp(4) then hs_char+=1 end
		if hs_char>8 or btnp(5) then
			if hs_pos then unlock_beastly_from_high_score_name() end
			save_data()
			hs_pos=nil
		end
		return
	end
	if btnp(4) then init_game() end
end

function update_complete_state()
	if btn(4) or btn(5) then return end
	if btnp(4) or btnp(5) then
		game_over()
	end
end

function update_enter_state()
	update_stars()
	lane_effects={}
	player.depth=min(0,player.depth+player.zspeed)
	if not zoom_active then game_state=G_ACTIVE end
end
--$switch-compiler: none
function update_play_state()
	local playing=game_state==G_ACTIVE
	lane_effects={}
	update_stars()
	get_input()
	update_player(player)

	for o in all(player_objects) do
		if o.active then
			if o.type==PSHOT then
				update_pshot(o)
			elseif o.type==DROID then
				if playing then update_droid(o)
				else o.active=false end
			end
		end
	end

	if playing then
		do_super_zap()
		do_wave()
	end

	for o in all(world_objects) do
		if o.team==ENEMY and o.hit then resolve_enemy_hit(o) end
	end

	for o in all(world_objects) do
		if o.active then
			if o.team==ENEMY
				or o.type==SPIKE or o.type==ESHOT then
				update_enemy(o)
				if not playing and o.type==SPIKE
				and lane(o.pos)==lane(player.pos)
				and player.depth>=o.depth and player.depth<160 then
					kill_player(ZAP,o)
				end
			elseif o.team==PUFX then
				update_pufx(o)
			end
			o.pos=clamp_pos(o.pos)
		end
	end

	if playing then
		if game_score>=game_extends_granted*0x0.4e20 then
			game_lives+=1
			game_extends_granted+=1
			oneup_timer=60
		end
		check_for_stage_end()
	end
end
--$switch-compiler: parens8
function update_warp_state()
	lane_effects={}
	update_stars()
	update_player(player)
	for o in all(world_objects) do
		if o.team==PUFX and o.active then update_pufx(o) end
	end

	if game_stage_transition_complete then
		advance_warp_stage()
		return true
	end
end

function finish_frame_update()
	finish_object_updates(player_objects)
	finish_object_updates(world_objects)
	update_camera(player.pos)
end
--$switch-compiler: none

function _update60()
	if crt_adjust then adjust_y = 4 else adjust_y = 0 end
	game_world_tics+=1
	local m=mouse_opts[1] and stat(34)>0
	local accept=btnp(4) or m and not mouse_down
	mouse_down=m
	if game_state==G_COMPLETE then
		cycle_palette(flr(game_world_tics/16))
	else
		cycle_palette(game_world_tics)
	end
	pulsar_frame=pulsar_anim[flr(game_world_tics/pulsar_deadliness)%16+1]
	spawn_data[PUTANKER].shape=spawn_data[PUTANKER].shapes[pulsar_frame]

	if game_state==G_MENU then
		update_menu_state(accept)
		return
	end

	if game_state==G_DEADMESSAGE then
		update_dead_message_state()
	end

	if game_state==G_GAMEOVER then
		update_game_over_state()
		return
	end

	if game_state==G_COMPLETE then
		update_complete_state()
		return
	end

	if game_state==G_ENTER then
		update_enter_state()
	elseif game_state==G_ACTIVE or game_state==G_LEAVING then
		update_play_state()
	elseif game_state==G_WARP then
		if update_warp_state() then return end
	end

	finish_frame_update()
end

function draw_menu(text,y)
	y=(y or 72)-adjust_y
	local menu_text=split(text)
	local x=24+menu_x
	for i=1,#menu_text do
		local s=menu_text[i]
		if game_menu==M_OPTIONS then
			s..=" "..(i==1 and (mouse_opts[1] and "on" or "off") or i==5 and (crt_adjust and "on" or "off") or i<4 and ((mouse_opts[i]+1)/4) or mouse_opts[i]>0 and mouse_opts[i]*10 or "off")
		end
		local color=game_menu==M_OPTIONS and i>1 and i<5 and not mouse_opts[1]and COL_GREY or COL_WHITE
		print(s,x,y+i*8,color)
		if i==menu_selection then
			print(">",x-8,y+i*8,COL_WHITE)
		end
	end
end

function draw_scores()
	gpu_text("CHAMPIONS",7,10,2.5)
	for i=1,5 do
		local s=""
		for j=1,8 do
			local n=hsn[(i-1)*8+j]
			s..=n>0 and chr(64+n) or " "
		end
		local y=22+i*12
		gpu_text(tostr(i),0,y+3,1,nil,nil,nil,6)
		gpu_text(s,18,y+3,1,nil,nil,nil,6)
		gpu_text(tostr(hs[i],2),76,y+3,1,nil,nil,nil,6)
	end
	if hs_pos then print("^",20+(hs_char-1)*4,23+hs_pos*12) end
end

function draw_stage_select_preview()
	submit_stars()
	update_view()
	for i=1,game_active_web.lanes do
		apf(lane_quad(i),i%2>0 and COL_WEB1 or COL_WEB2)
	end
	draw_web()
	gpu_draw(web_spokes)
end

function draw_menu_state()
	if data_scores then draw_scores() return end
	if game_menu==M_STAGE_SELECT then
		draw_stage_select_preview()
	else
		draw_tempest_logo(0,0,120,5)
		draw_tempest_logo(0,0,120,COL_LIGHT_GREY,1)
		gpu_text("2000",5,48,6,3,COL_BLACK)
		gpu_text("2000",5,47,6,3,COL_YELLOW)
		if reset_confirm then
			print("this will erase all",26,88,COL_WHITE)
			print("settings and high scores.",18,96,COL_WHITE)
			print("are you sure?",38,104,COL_WHITE)
			print("\142 yes  \151 no",34,116,COL_WHITE)
			return
		end
		if game_menu==M_MAIN then
			print(get_message(S_TITLE_CREDIT_1)[5],0,64-adjust_y,COL_WHITE)
			print(get_message(S_TITLE_CREDIT_2)[5],2,72-adjust_y,COL_WHITE)
			print(get_message(S_TITLE_CREDIT_3)[5],1,80-adjust_y,COL_WHITE)
		end
	end

	draw_menu(menu_items(),menu_y())
	print("\142 to select \151 to return",12,122-adjust_y,COL_WHITE)
end

function draw_game_web()
	update_view()
	submit_stars()
	if not web_visible then return end

	if game_state>=G_LEAVING and game_state<G_DEADMESSAGE then
		fillp(~(0xffff<<min(16,player.depth/5)),true)
	end
	for i=1,game_active_web.lanes do
		apf(lane_quad(i),i%2>0 and COL_WEB1 or COL_WEB2)
	end
	fillp()
	draw_web()
end

function draw_score_awards()
	if oneup_timer<=0 and #score_awards==0 then return end

	fillp(0x5a5a,true)
	if oneup_timer>0 then
		set_affine(scratch_mat,8-oneup_timer/7.5,0,64,64)
		poke(0x5f5e,0x55)
		gpu_draw(score_shapes[6],scratch_mat)
		oneup_timer-=1
	end
	poke(0x5f5e,0xbb)
	for award in all(score_awards) do
		local x,y,z=project(award[2],award[3])
		if x then
			set_affine(scratch_mat,-camera_focal/z,0,x,y)
			gpu_draw(award[1],scratch_mat)
		end
		award[3]-=1
		award[4]-=1
		if award[4]<0 then del(score_awards,award) end
	end
	poke(0x5f5e,0xff)
	fillp()
end

function draw_web_effects()
	if not web_visible then return end
	gpu_draw(web_spokes)
	for i=1,num_lanes do
		if lane_effects[i] then
			draw_quad(lane_quad(i),lane_effects[i])
		end
	end
end

function draw_complete_state()
	cls()
	fillp()
	local y=16
	for line in all(split(game_complete_message,"|")) do
		gpu_text(line,0,y,1,nil,COL_CYCLE_COOL,nil,6)
		y+=8
	end
end

function draw_gameplay_state()
	draw_game_web()
	draw_score_awards()
	draw_web_effects()

	if game_state<G_MENU then build_draw_list() end
	if super_zap_target then
		draw_zap(
			player.pos,
			player.depth,
			super_zap_target.pos,
			super_zap_target.depth
		)
		super_zap_target=nil
	end
	draw_hud()
	if game_warp_flash>0 then
		rectfill(0,0,127,127,COL_WHITE)
		game_warp_flash-=1
	end
end

function _draw()
	cls()
	if game_state==G_GAMEOVER then
		draw_scores()
	elseif game_state==G_COMPLETE then
		draw_complete_state()
	elseif game_state==G_MENU then
		draw_menu_state()
	else
		draw_gameplay_state()
	end
end

__gfx__
91c0df01ff0110013001500170019001b001d001f0011101310112011010203030504070509060b070d080f0a0f0b0d0c0b0d090e070f0500130111012011010
103010501070209040b060c080c0a0c0c0c0e0b001901170115011301110120180607040505040706080409050b070c080a090c0b0b0c090a080c070b0509040
12017020503030502070209030b050d070e090e0b0d0d0b0e090e070d050b03090201201103020503070409050b060d070f090f0a0d0b0b0d0b0e090f0700150
1130211012017060505030501070109030b050b070a090a0b0b0d0b0f090f070d050b050906012017070505030501070109030b050b070909070b050d050f070
f090d0b0b0b0909052218010703060505070409030b020d040d060d080d0a0d0c0d0e0d0d0b0c090b070a0509030120170307050507030703090509070b070d0
90d090b0b090d090d070b07090509030120140404060408040a040c060c080c0a0c0c0c0c0a0c080c060c040a04080406040f1f0df80ffa010c030e0500160e0
70c080a090c0a0e0b001d0e0f0c011a03180f1f0efe0efc0ffa0108030705070708090a0b0c0d0d0f0d011c031a041804160d1e010f020d030b0409050707050
9040b040d050f070019011b021d031f05221805060404030202030404060508060a070c080e090c0a0a0b080c060d040e020c030a04012011040ff60ff8010a0
30a040c050e06001800190e0a0c0b0a0d0a0f080f060d040b1d060104020304020603080509070a090a0b090c070d050e030f010d1e0c030a030803060404060
308030a030c050c070c090b0b090c070c050f1f0df30df50df70df90dfb0ffd010d030c050b070a09090b080d070f0600140d1e0ff01dff0dfd0dfb0ff901080
30705060704080209000a0efc0dfe0df118070505070509070b090b0b090b070905091c0705050703080509070b080d090b0b090d080b0709050803012011090
20b040c060d080d0a0c0c0a0d080d060c040b020901070105030505070605221108010a020c040d060e080e0a0e0c0d0e0c0f0a0f080e060c050a04080406040
40502060b1d080df80ff7010503030502070209030b050d070e090e0b0d0d0b01201803080507070508030805080709080b080d080b09090b080d080b0809070
8050f1f0802060404060208030a040c050e070e090e0b0e0c0c0d0a0e080c060a040b1d0ef80ff60105030405030701080ff9010b030d040f05011602180f1f0
20c040c060c080c0a0c0c0c0e0c0e0a0d080b060905070505060308020a0d1e0ef00ef20ef40ef60ef80ffa010c030d050d070d090d0b0c0d0c0f0d052212001
40e040014021500160e070c080a090807060507030801090ffa0dfb0ffb010b0ffd0b1d0df40cf60cf80dfa0ffb010b030a020c020e030015011701190011201
801060204000302010303040406060808080a080c060d040f030d020c000a020f1f080ff8010703050504070409050b070c090c0b0b0c090c070b05090308010
f1f010ef1000202020403060308040a040c050e0500160218021a011c011e001b1d02070309050a070b090b0b0a0d090e070c060a060807060604060120160a0
40c060e080e0a0d0c0c0e0b0f090f070e050c040a03080206020404060602120ff10b0cfc0102030405060708090a0b0c06120ff10b0cf011020304050607080
90a0b0c0d0e0f00130001b406120ff10b0bf01102030405060708090a0b0c0d0e0f0013000cc4030001b403000cc403000cc408120ff10b0bf21102030405060
708090a0b0c0d0e0f00111213000cc403000cc405120ff10b0cff0102030405060708090a0b0c0d0e0f0300041504120ff10b0cfe0102030405060708090a0b0
c0d0e030003f4030001b403120ff10b0cfd0102030405060708090a0b0c0d04120ff10b0bfe0102030405060708090a0b0c0d0e0300041503000e250e020ff10
b0bf8010203040506070802120ff10b0bfc0102030405060708090a0b0c030001b4030003f403000b4503000cc405120ff10b0bff0102030405060708090a0b0
c0d0e0f03000b4503000ea503000e2508120ff10b0cf21102030405060708090a0b0c0d0e0f00111213000b4503000cc403000ea50300041503120ff10b0bfd0
102030405060708090a0b0c0d030001b40b1d00000cf0040000fcf01cf0f40014000cf0040408f4080cf8fcf8091c000ffff00efffffdf20ef0010ef10cfefff
bf40df3040cf5092418f00cfdfcfff0000df8f20bf00cf000060bf500040ef00007050205030300000ef80cf30ef40000092418f00cf30cf100000df8fcfdfef
df000060bf10bf20df00007050500040100000ef8020500040000051a07f00af60af40df0000af00cf300060606040900051a07f00af50af30df0000bf00df30
0060506030900051a07f00af40af20df0000cf00ef300060406020900051a07f00af30af10df0000df00ff300060306010900051a07f00af20af00df0000ef00
00300060206000900051a07f00af10afffdf0000ff00103000601060ff9000d1e04fcfcf8f408fc0cfc0404080cf804f408fcfcfcfcf0080cf40cf400011800f
ce0f8f4f4f4fcfcf8f804040404001118001ce018fc04fc0cf408f8f40cf40cf011180dfdf6090c060c00030df90009060606011809060c00030df900090307f
00dfdf4f0011803060c00030df900060307f00dfdf4f0011803060c00030df900030307f00dfdf4f001180df60c00030df9000df307f00dfdf4f001180af60c0
0030df9000af307f00dfdf4f0011807f60c00030df90007f307f00dfdf4f0011804f30af9030dfaf607f607f00dfdf4f00904000df20000020ef0015820e002e
4f9e9e4f2e000ec02e719ee14f0200e1c07171c0e100024fe19e712ec02cfe3d3dfe2c112cd23de3fee311d2d211e3fee33dd22c111800290c0c290018f329e6
1cf700e60404e600f70ce629041180a000707000a09f706f009f9f006f709fd060ef00308f3000400000800000120140005000401050100040104000501050cf
00df00cf10df1000cf10cf00df10df91c08f00bf00cfffcf10409f20cf30df10cf407030401040303091c09fcf9f40ff00500070cf008f10ffef400080704000
10dfcf3000bf70d0608f00cf0000cf00404000800011808f00cf0000cf00404000800000af0060f0700000cf0040008f7f807f8f90809011800020804000af80
cf8f4000608fcf00eff0709fcf108f70cf704010809f40100011808f8f808f80808f80cfcf40cf4040cf4015828f00cfdfcfff0000df8f20bf00cf000060bf50
0040ef00007050205030300000ef80cf30ef4000008f00cf30cf100000df8fcfdfefdf000060bf10bf20df00007050500040100000ef8020500040000092417f
00af60af40df0000af00cf3000606060409000900060af60cf300000600040df00afafafcf7f0092417f00af50af30df0000bf00df3000605060309000900060
bf60df300000500030df00afbfafdf7f0092417f00af40af20df0000cf00ef3000604060209000900060cf60ef300000400020df00afcfafef7f0092417f00af
30af10df0000df00ff3000603060109000900060df60ff300000300010df00afdfafff7f0092417f00af20af00df0000ef00003000602060009000900060ef60
00300000200000df00afefaf007f0092417f00af10afffdf0000ff00103000601060ff9000900060ff60103000001000ffdf00afffaf107f0012018000606000
80af608f00afaf008f60af400030300040df30cf00dfdf00cf30df51a0afafffef50af30ff703020201070ef20af40dfff3a15ce8fee6f4f6f7f8f7fcf4fdf4f
bf3f9ffe9fdebfbeaf4fbf7fcf6f003f30fe50de80be70ce400f103fffce60fe707f707fa0bea0be70bf6f606f509fef9fdfdfafdfbfcf30cf60ef60604090df
a0af80cf60ef7020603040301020ffcfffaf7fef8fdfefafffb06f316f518f51bf31cf21af119fd09fb0afa0cf90bf908f909fc0afc060a080907021af519f51
7041802160a060c07021704160518031a0b0a090809a45ce6f7f6f6f9ffe9feedfbedfcecf4fcf7fef7f605f90eea0be80de60fe703f604f404f103fffdeffbe
7ffe8feeefbeffcf6f406f608f60bf40cf30af209fef9fcfafbfcfafbfaf8faf9fdfafdf60bf80af7030af609f607050803060bf60df7030705060608040a0cf
a0af80b06f316f518f51bf31cf21af119fd09fb0afa0cf90bf908f909fc0afc060a080907021af519f517041802160a060c07021704160518031a0b0a0908038
14be6f7f6f7f9f4fcf1f10fe80dea0ce80ee002f9fce9fbf6f606f509fef9fdfdfafdfbfcf30cf60ef60604090dfa0af80cf60ef7020603040301020ffcfffaf
7fef8fdfefafffb06f316f518f51bf31cf21af119fd09fb0afa0cf90bf908f909fc0afc060a080907021af519f517041802160a060c07021704160518031a0b0
a09080bc565eaf9e6fde6fde700f80fea07ea06e809e709ebf7edf5f6fdf6fff8fffbfdfcfcfafbf9f7f9f5faf4fcf3fbf3f8f3f9f6faf6f604f803f70cfafff
9fff70ef80cf604f606f70cf70ef60ff80dfa05fa03f80406fc06fe08fe0bfc0cfb0afa09f609f40af30cf20bf208f209f50af506030802070b0afe09fe070d0
80b06030605070b070d060e080c0a040a02080316fb16fd18fd1bfb1cfa1af919f519f31af21cf11bf118f119f41af416021801170a1afd19fd170c180a16021
604170a170c160d180b1a031a01180be575e8f7e6fde6f0f8f0fcfdedfdebfce9f8e9f6ebf4eafdebf0fcffe00ce308e506e804e705e409e10ceff5e608e700f
700fa04ea04e705f6fdf6fff8fffbfdfcfcfafbf9f7f9f5faf4fcf3fbf3f8f3f9f6faf6f604f803f70cfafff9fff70ef80cf604f606f70cf70ef60ff80dfa05f
a03f80406fc06fe08fe0bfc0cfb0afa09f609f40af30cf20bf208f209f50af506030802070b0afe09fe070d080b06030605070b070d060e080c0a040a0208031
6fb16fd18fd1bfb1cfa1af919f519f31af21cf11bf118f119f41af416021801170a1afd19fd170c180a16021604170a170c160d180b1a031a011809643fd5f5e
cefecefed05f016f410e41fd015ed05e9f1e9ffe4f7f4f7f709fa0cfa0cf117f112fe0fe80cfa0ef70ef4f604f608030e0ff11cf11604fe04fe0416041c04f91
4fe17f12cfb1ef91bf61afc0af12cf1250e1a0a150b120b1efe1a091d0c0d0c0707170a15015822100d0d000213fd0ee003f3f00eed03f6380b22241338f63ed
b2dc41ac8f5dedcedc80ac225d33ce9650265225249385b156bf96bd26eb258a93b9b179bfe9bdeaeb7c8a5eb9507952e924ea857c565e9a450e9f6e9f6ecf2e
cf2eef5eef5e102e102e406e406e700e707e9f9e9fde70ce70ce9fde9f9e707e705f9ffe9ffe705f705f400f400fcf5fcf6f9fcf9fcfcf8fcf8fefbfefbf108f
108f40cf40cf706f70df9fff9fff4030403070df70409f609f6040a040a0704070b09f119f11cfd0cfd0ef01ef0110d010d04011401170b070319f419f417031
70419f619f91707170719f919f91707170a19f029f02cfa1cfc1bfe1bfe170c17075b25f9f7f9f9f00af9fcf9faf10af708f708f10ef9f309f30cf00cf00ef20
ef20100010004030403070ef70609fa09fb0afb0cf80cf70df70ef80ffa0ffb000b050a07060705060504080409030902080106010500050bf2531ff10508f30
a050108f3070b0108f30d060108f3040c010ff10908f30402010ff10a08f305030108f30602010ff10908f30703010ff10908f30a08010ff10a08f3090b0108f
30c08010ff10908f30d090102120ff1060cfc0102030405060708090a0b0c01541ff10808f30102030ff10808f30402030ff10708f30506070ff10708f308060
70ff10608f3090a0b0ff10608f30c0a0b0ff10508f30d0e0f0ff10508f3001e0f0ff10408f30112131ff10408f304121313000f50113c0ff10f08f30102030ff
10f08f30203040ff10f08f30405060ff10f08f30506070ff10f08f30708090ff10f08f308090a030005b0130005b0130005b0130005b0130005b011401ff1010
8f30102030ff10208f30103040ff10208f30108050ff10208f30104050ff10208f30807050ff10208f30706050ff10908f3090a0b0ff10908f30e0d0c01280ff
10408f30102030ff10408f30203040ff10408f30304050ff10308f306070801280ff10408f30302010ff10408f30403020ff10408f30504030ff10308f308070
602270ff10408f308010208f304050608f303040608f303060708f302030708f302070802270ff10408f302030408f302040508f301020508f308010508f3080
50608f306070802270ff10408f302030408f301020408f301040508f301050608f306070808f301060802270ff10408f302030408f301020408f301040508f30
8010508f308050608f306070803000ae113000ae113000ae112270ff10408f302030408f302040508f306070808f305060808f305080108f30102050a020ff10
609f40102030408360ff10f0df01102030405060708090a0b0c0d0e0f001ff10f0dfc0112131415161718191a1b1c1ff10f0dfc0d1e1f1021222324252627282
e020ff10e0df8010203040506070801140ff10408f30102030ff10408f304050606120ff10f0df01102030405060708090a0b0c0d0e0f0013140ff10408f3010
30408f305070808f3090b0c06140ff1040bf4010203040bf4050607080bf4090a0b0c08360ff10e0df01102030405060708090a0b0c0d0e0f001ff10e0dfc011
2131415161718191a1b1c1ff10e0dfc0d1e1f10212223242526272821280ff10908f30102030ff10908f30605030ff10908f30102040ff10908f3060504013c0
ff10a08f30702050ff10a08f30802050ff10908f30102030ff10908f30605030ff10908f30102040ff10908f306050401280ff10908f30402010ff10908f3050
3010ff10908f30602010ff10908f307030100270ff10f0bf4010204030bf4050608070cf201050cf202060cf203070cf20408013c0ff10708f30102070ff1030
8f30203070ff10208f30304070ff10108f30405070ff10208f30506070ff10308f306010701401ff10108f30102050ff10508f30203060ff10508f30304070ff
10108f30401080ff10208f30506020ff10808f30607030ff10808f30708040ff10208f308050101a82ff10808f30102030ff10808f30402030ff10708f305060
70ff10708f30806070ff10608f3090a0b0ff10608f30c0a0b0ff10508f30d0e0f0ff10508f3001e0f0ff10408f30112131ff10408f30412131ff10808f305161
71ff10808f30816171ff10708f3091a1b1ff10708f30c1a1b1ff10608f30d1e1f1ff10608f3002e1f1ff10508f30122232ff10508f30422232ff10408f305262
72ff10408f308262721681ff10f08f30102030ff10f08f30203040ff10f08f30405060ff10f08f30506070ff10f08f30708090ff10f08f308090a0ff10f08f30
b0c0d0ff10f08f30c0d0e0ff10f08f30e0f001ff10f08f30f00111ff10f08f30112131ff10f08f302131418130ff10e0bf801020304050607080bf8090a0b0c0
d0e0f0010120ff1040bfa0102030405060708090a096b0ff10609fb0102030405060708090a0b09fa0c0d0e0f00111213141519f6061718191a1b19f60c1d1e1
f102129fe02232425262728292a2b2c2d2e2f29f40031323339fc0435363738393a3b3c3d3e3f39f5004142434449f5054647484949f80a4b4c4d4e4f40515e6
c0ff10609f601020304050609fe0708090a0b0c0d0e0f001112131419f40516171819fc091a1b1c1d1e1f102122232429f5052627282929f50a2b2c2d2e29f80
f2031323334353639fc0738393a3b3c3d3e3f30414249f5034445464749f508494a4b4c49f80d4e4f405152535455590ff10609fb0102030405060708090a0b0
9f60c0d0e0f001119fe02131415161718191a1b1c1d1e1f19f40021222329fc0425262728292a2b2c2d2e2f29f5003132333439f5053637383939f80a3b3c3d3
e3f3041438e0ff10609fb0102030405060708090a0b09fc0c0d0e0f001112131415161719f508191a1b1c19f50d1e1f102129f8022324252627282929fc0a2b2
c2d2e2f20313233343539f5063738393a39f50b3c3d3e3f39f8004142434445464749fc08494a4b4c4d4e4f4051525359f5045556575859f5095a5b5c5d59f80
e5f50616263646567901ff10609fb0102030405060708090a0b09fa0c0d0e0f00111213141519f6061718191a1b19fc0c1d1e1f102122232425262729f508292
a2b2c29f50d2e2f203139f8023334353637383939fc0a3b3c3d3e3f30414243444549f5064748494a49f50b4c4d4e4f49f8005152535455565759fc08595a5b5
c5d5e5f5061626369f5046566676869f5096a6b6c6d69f80e6f60717273747576480ff10109fb0102030405060708090a0b09f90c0d0e0f001112131419f8051
61718191a1b1c19f40d1e1f1029f8012223242526272829f6092a2b2c2d2e29f60f203132333438360ff1030df801020304050607080ff1040dfc090a0b0c0d0
e0f00111213141ff10f0df415161718191a1b1c1d1e1f102122232425262728227e0ff10609fc0102030405060708090a0b0c09f40d0e0f0019f40112131419f
805161718191a1b1c19fc0d1e1f10212223242526272829f6092a2b2c2d2e29f60f203132333439fc05363738393a3b3c3d3e3f3049f40142434449f40546474
849f4094a4b4c49f40d4e4f4059f4015253545d360ff10409f40102030909f40405060309f5030607080909fc0a0b0c0d0e0f00111213141519f6161718191a1
b1c1d1e1f102122232425262728292a2b2b050ef3000df2030ff00100091c0efdfef301030202020101000ef00100020ff20ef10dfefdf904020dfefdfef3020
30f070efdfef301030202020ef10dfefdfd06020dfefdfef302030ef001000b050efdfef3020dfef001000d06020dfefdfef30203020000000d060efdfef3020
df2030ef002000d060efdf20df00df0030ef302030d060efdf20df20201030ff30ef20b050efdfef3020dfef0020307030efdfef302030b050ef30efdf000020
df20309040ef30efdf203020df9040efdf20df2030ef30f070ef30efdf10df20ef20ff1000ef00d060efdf20df2030ef30001020303190ef30efdf10df20ef20
ff1000ef00ff002030d06020dfefdfef0020002030ef309040efdf20df00df0030d060efdfef20ff301030202020df7030efdf003020dfb050efdfff30000010
3020df9040efdf203020dfef309040efdf000020df00309040efdf20dfef302030703000df00100030b050ffef00df0030ff301030f070efefffdf10df20ef20
ffef30203071b0efdf10df20ef20ff1000ff001000201020201030ef309040103010dfef102010118020dfefdfef001000201020201030ef3071b020ef10dfff
dfefefef20ff301030202020101000ef007030efdf20dfff301201ffdf10df20ef20ff1000ff00efffefefff001000201020201030ff30ef20ef1051a02000ff
00efffefefffdf10df20ef20201030ff301180ffdf10df20ef20201030ff30ef20efeff5f2d600d6b087b037f0d6f0d6f1e64227528712f6e23673b473846324
0304a204c114e144e174c1848164312421f341e381e3d20413c373a373b381933124f08401b46194f1147214c25413f4539563264396e2c692962296f056e046
c0968091c036d0e0e0f06221c27113f0d2b082a0e000e09090e000e0b013818313838243225391434123410371f282d212d251a24182618202c252e2a2a25232
12425182f0b2f0f22143f08311836191c0326151c171f1b112f10232e1e132613211e111716121d121b1d06511a531c56105c105d155129502c5d195222532d4
f1c48105215221c47285921652361236e1d561d52116f0760186614611163186d1762246620692a5a22592b05041a1e161b141815151719040f4a17551554125
5191400515253545556575455565758595a5b58595a5b5c5d5e5f58595a5b5c5d5e5f58595a5b5c5d5e5f506162636465666768696040444448484c4c4040444
448484c4c40404c4c40505c5c50404c4c40505c5c50404c4c40505c5c50505c5c506064646050586860787088809898686078708880989868607870888098986
860787088809890a0a8a8a0b0b0b0b8a0b0b8b8b0c0c0c8a0b040404040404448484c4054585c50646054585c5064686c6054585c5064686c6054585c5064686
c6064686c6074787c78647d1d100009020150030d1004250cc10600400700000800000900000a13000b1d0008033435363738393a35020240030c100500000a0
0000a1600041e00010b35020140030c100600c10b00080a1600081810010f37010e00020140030c100600420b00840c2a1700011710010644020240030c100b0
0010a16000710100100460201400600c00b00040d02000910000a1600091b10020231370100100201400600e00b00040d02000e2910000211010105450f09000
03110800916900a19000f08010103440f0000003916900a1900001c010104450f000000383916900a1900041b0103003132350f0000003213000916900a1a000
e02020106230b00040914600a15000f03030107240b0004003916900a16000011100004020140021e100913000a1600001500060a2b2c2d2e2f220918c00a1f0
0061410060a2b2c2d2e2f240203400600800916900a1f000d0404020829230b0002099a18000e06020109430b00010914600a1f00031702060a4b4c4d4e4f430
b00010914600a1f000c09040107430b000102150009990a010108420b4002099f1310030c324858020140030e1003123004100005108106100a0710000a1f000
41510010145020140030e100b00030318000a160004221002024e3a020e40030e100600c00d0020031c40041002051000061f820710000a1e00011910010d340
20140030e100b00010a1e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
