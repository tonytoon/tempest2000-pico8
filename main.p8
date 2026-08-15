pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
--[tempest 2000 0.9.8]
--by [deepthaw]
--[[const]] game_stage_max=99
--[[const]] game_update_num=2
#include enums.p8
#include colors.p8
#include packed_data.p8
#include difficulty.p8
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
#include messages.p8
#include menu.p8

-- mouse enabled,sensitivity,jump; spinner enabled,sensitivity.
-- the numbers are indexes to save tokens:
-- sensitivity/max=(value+1)/4 and jump=value*10 (0 means off)
menu_selection=1

--
-- dget(6)/dset(6) settings word bit layout (kept non-overlapping, see save_settings/load_init_data):
--   bit 0      mouse enabled
--   bits 1-4   mouse sensitivity (0-15)
--   bits 5-8   unused (formerly mouse max lanes)
--   bits 9-11  mouse jump (0-7)
-- dget(47)/dset(47): bits 0-6 beastly high stage, bit 7 spinner enabled,
-- bits 8-10 spinner sensitivity (xor 3 so legacy enabled saves load as 1.0)
-- dget(48)/dset(48) is the last viewed whatsnew version

--$switch-compiler: parens8

function reset_settings()
	mouse_opts={false,3,0,false,3}
	game_regular_high_stage=1
	game_beastly_high_stage=1
	game_beastly_unlocked=false
end
reset_settings()

function load_and_init_data()
	cartdata"tempest2000v093"
	hs,hsn,hsf={},{},{}
	for i=0,4 do add(hs,dget(i)) add(hsf,dget(i+49)) end
	for i=7,46 do add(hsn,dget(i)) end
	if hs[5]==0 then
		reset_data()
	end
	p=dget(5)
	game_regular_high_stage=mid(1,p&127,game_stage_max)
	game_beastly_unlocked=p>=128
	p=dget(6)
	if p~=0 then
		mouse_opts={(p&1)>0,p>>1&15,p>>9&7}
	end
	p=dget(47)
	game_beastly_high_stage=mid(1,p&127,game_stage_max)
	mouse_opts[4],mouse_opts[5]=p&128>0,(p>>8&7)^^3
	if game_beastly_unlocked then
		game_regular_high_stage=game_stage_max
	end
end

function save_data()
	for i=1,5 do dset(i-1,hs[i]) dset(i+48,hsf[i]) end
	for i=1,40 do dset(i+6,hsn[i]) end
	save_settings()
end

function save_settings()
	dset(5,game_regular_high_stage|(game_beastly_unlocked and 128 or 0))
	dset(6,(mouse_opts[1] and 1 or 0)
		|mouse_opts[2]<<1
		|mouse_opts[3]<<9)
	dset(47,game_beastly_high_stage|(mouse_opts[4]and 128or 0)|(mouse_opts[5]^^3)<<8)
end

function reset_data()
	reset_settings()
	dset(48,0)
	hs={
		0xa.6040, -- 680000
		0x7.d000, -- 512000
		0x6.68a0, -- 420000
		0x4.caf4, -- 314100
		0x0.c350  -- 50000
	}
	hsf={0,0,0,0,0}
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
			add(hsf,(game_pure and 1or 0)+(game_beastly and 2or 0),i)deli(hsf,6)
			for j=40,i*8+1,-1 do hsn[j]=hsn[j-8] end
			for j=1,8 do hsn[(i-1)*8+j]=j<2and 1or 0 end
			hs_pos,hs_char=i,1
			return
		end
	end
end

function unlock_beastly_from_high_score_name()
	local name=""
	for i=hs_pos*8-7,hs_pos*8 do
		local n=hsn[i]
		if(n<1)break
		name..=chr(64+n)
	end
	local u=name=="RIMMER"and 1or name=="KRYTEN"and 2or name=="HOLLY"and 3
	if u then
		game_regular_high_stage=game_stage_max
		if(u>1)game_beastly_unlocked=true
		if(u>2)game_beastly_high_stage=game_stage_max
	end
end

function add_score(s,p,d,q)
	if(q)add(score_awards,{q,p,d,150})
	if game_beastly then s*=2 end
	game_score+=s*0x0.0001
end

--$switch-compiler: none
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

	local s="score:"..tostr(game_score,2)
	print(s,1,1,COL_GREY)
	print(s,0,0,COL_WHITE)

	local wc = game_warp_powerups >= 3 and COL_CYCLE_HOT or COL_GREEN
	print("warp:",1,9,COL_GREY)
	local x = print("warp:",0,8,COL_WHITE)
	for i=1,game_warp_powerups do
		x=print(chr(143),x,8,wc)
	end

	s="lives:"..game_lives
	print(s,97,1,COL_GREY)
	print(s,96,0,COL_WHITE)

	s=game_bonus_stage and "????" or 'stage:'..game_stage
	print(s,97,9,COL_GREY)
	print(s,96,8,COL_WHITE)
	if game_bonus_stage then
		rect(37,116,90,123,COL_GREY)
		if(bonus_powerups>0)rectfill(38,117,37+bonus_powerups*2,122,COL_WEB_SPOKES)
		print("megaspeed",46,118,COL_WHITE)
	end

	show_messages()
end

lane_effects = {}
--$switch-compiler: parens8

function _init()
	init_palette(palettes[1])
	init_packed_data()
	init_spawn_data()
	init_shapes()
	init_tempest_logo()
	load_and_init_data()
	game_beastly=false
	init_game()
	poke(0x5f2d,mouse_opts[1] and 5 or 0)
end

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


function update_game_over_state()
	if hs_pos then
		local d=btnp(2)and 1or btnp(3)and-1or 0
		local k=hs_pos*8+hs_char-8
		hsn[k]=(hsn[k]+d)%28
		if btnp(4) then
			if hsn[k]>26 then
				hsn[k]=0
				hs_char=9
			else
				if(hs_char<8)hsn[k+1]=hsn[k]
				hs_char+=1
			end
		elseif btnp(5) and hs_char>1 then
			hs_char-=1
			hsn[k]=0
		end
		if hs_char>8 then
			unlock_beastly_from_high_score_name()
			save_data()
			hs_char=-hs_pos
			hs_pos=nil
		end
		return
	end
	if btnp(4) then init_game() end
end

function update_complete_state()
	local b=btn(4)or btn(5)
	if complete_input==2 and not b then game_over()
	elseif b and complete_input>0 then complete_input=2
	elseif not b then complete_input=1 end
end

function update_enter_state()
	update_stars()
	lane_effects={}
	if(game_bonus_stage and zoom_active)bonus_dist+=game_warp_speed
	player.depth=min(0,player.depth+player.zspeed)
	if not zoom_active then game_state=G_ACTIVE end
end

--$switch-compiler: none

function update_play_state()
	local playing=game_state==G_ACTIVE
	lane_effects={}
	if(not game_bonus_stage)update_stars()
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
		if game_bonus_stage then update_bonus_stage() else do_wave() end
	end

	for o in all(world_objects) do
		if(o.team==ENEMY and o.hit)resolve_enemy_hit(o)
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
		if not game_bonus_stage and game_score>=game_extends_granted*0x0.4e20 then
			game_lives+=1
			game_extends_granted+=1
			oneup_timer=60
		end
		check_for_stage_end()
	end
end

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

--$switch-compiler: none

function _update60()
	game_world_tics+=1
	cycle_palette(game_state==G_COMPLETE and flr(game_world_tics/16)or game_world_tics)
	pulsar_frame=pulsar_anim[flr(game_world_tics/pulsar_deadliness)%16+1]
	spawn_data[PUTANKER].shape=spawn_data[PUTANKER].shapes[pulsar_frame]

	if game_state==G_MENU then
		update_menu_state(btnp(4))
		return
	end

	if(game_state==G_DEADMESSAGE)update_dead_message_state()

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

	finish_object_updates(player_objects)
	finish_object_updates(world_objects)
	update_camera(player.pos)
end

-- menu-only drawing helpers
--$switch-compiler: packed_rom

function draw_menu(text,y)
	local menu_text=split(text,game_menu==M_UPDATE and "|" or ",")
	local x=(game_menu==M_UPDATE and 4 or 24)+menu_x
	for i=1,#menu_text do
		local s=menu_text[i]
		if game_menu==M_OPTIONS and i<6 then
			s..=" "..((i==1or i==4)and(mouse_opts[i]and"on"or"off")
				or(i==2or i==5)and(mouse_opts[i]+1)/4
				or mouse_opts[i]>0and mouse_opts[i]*10or"off")
		end
		local color=game_menu==M_OPTIONS and (i>1and i<4and not mouse_opts[1]or i==5and not mouse_opts[4])and COL_GREY or COL_WHITE
		if(game_menu==M_MAIN and i==#menu_text and game_update_num>dget(48))s="\fe\143"..s
		print(s,x,y+i*8,color)
		if i==menu_selection and game_menu<M_UPDATE then
			print(">",x-8,y+i*8)
		end
	end
end

function draw_scores()
	gpu_text("CHAMPIONS",7,10,2.5)
	for i=1,5 do
		local y=25+i*12
		local c=hs_char==-i and COL_CYCLE_COOL
		for j=1,8 do
			local n=hsn[(i-1)*8+j]
			local s=n>26and"ED"or n>0and chr(64+n)or" "
			gpu_text(s,12+j*6,y,n>26and.5or 1,n>26and 1,c or hs_pos==i and hs_char==j and COL_GREEN,nil,n>26and 4)
		end
		gpu_text(tostr(i),0,y,1,nil,nil,nil,6)
		gpu_text(tostr(hs[i],2),76,y,1,nil,c,nil,6)
		print(({"","\f6P","\f7B","\f6P\f7B"})[hsf[i]+1],116,y)
	end
	if hs_pos then
		local x,y=12+hs_char*6,30+hs_pos*12
		line(x,y,x+4,y,COL_WHITE)
		print("\142 to input \151 to delete",20,122)
	end
end

function draw_stage_select_preview()
	submit_stars()
	update_view()
	for i=1,web_fill and num_lanes or 0 do
		polyfill(lane_quad(i),i%2>0 and COL_WEB1 or COL_WEB2)
	end
	draw_web()
	gpu_draw(web_spokes)
end

--$switch-compiler: none

function draw_game_web()
	update_view()
	if game_bonus_stage then
		draw_bonus_web(bonus_dist)
		poke(0x5f5e,0x04)
		draw_blobs()
		poke(0x5f5e,0xff)
		return
	end
	submit_stars()
	if not web_visible then return end
	if game_state>=G_LEAVING and game_state<G_DEADMESSAGE then
		fillp(~(0xffff<<min(16,player.depth/5)),true)
	end
	for i=1,web_fill and num_lanes or 0 do
		polyfill(lane_quad(i),i%2>0 and COL_WEB1 or COL_WEB2)
	end
	fillp()
	draw_web()
end

function draw_score(q,m)
	if q>5 then gpu_draw(score_digits[q],m) return end
	local s=tostr(q==5 and 2000 or q*250)
	local x=#s<4 and -15 or -22
	local tx,ty=m[3],m[6]
	for i=1,#s do
		m[3],m[6]=tx+x*m[1],ty+x*m[4]
		gpu_draw(score_digits[sub(s,i,i)],m)
		x+=15
	end
	m[3],m[6]=tx,ty
end

function draw_score_awards()
	if oneup_timer==0 and #score_awards==0 then return end
	while(#score_awards>2)deli(score_awards,1)

	fillp(0x5a5a,true)
	poke(0x5f5e,0x55)
	local slow=game_bonus_stage and bonus_slow
	if oneup_timer>0 and not slow then
		set_affine(scratch_mat,8-oneup_timer/7.5,0,64,64)
		draw_score(6,scratch_mat)
		oneup_timer-=1
	elseif oneup_timer!=0 then
		local s=slow and 1.5 or 8+oneup_timer/7.5
		poke(0x5f5e,0xff)
		fillp()
		if(slow)fillp(~(0xffff<<min(16,(60-oneup_timer)/3.75)),true)
		set_affine(scratch_mat,s,0,64-8*s,64)
		draw_score(5,scratch_mat)
		clip(64+18*s,0,128,128)
		scratch_mat[3]+=15*s
		draw_score(5,scratch_mat)
		clip()
		fillp(0x5a5a,true)
		oneup_timer+=slow and -1 or 1
	end
	poke(0x5f5e,0xbb)
	for award in all(score_awards) do
		local x,y,z=project(award[2],award[3])
		if x then
			set_affine(scratch_mat,-camera_focal/z,0,x,y)
			draw_score(award[1],scratch_mat)
		end
		award[3]-=1
		award[4]-=1
		if award[4]<0 then del(score_awards,award) end
	end
	poke(0x5f5e,0xff)
	fillp()
end

function draw_complete_state()
	fillp()
	local y=16
	for line in all(split(game_complete_message,"|")) do
		gpu_text(line,0,y,1,nil,COL_CYCLE_COOL,nil,6)
		y+=8
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
		draw_game_web()
		draw_score_awards()
		if game_bonus_stage then
			local v=game_active_web.near_verts
			for i=1,num_lanes do
				local c=lane_effects[i]
				if c then
					local a,b=v[i],v[i%#v+1]
					draw_world_line(a[1],a[2],camera_z,a[1],a[2],camera_z+360,c)
					draw_world_line(b[1],b[2],camera_z,b[1],b[2],camera_z+360,c)
				end
			end
		elseif web_visible then
			gpu_draw(web_spokes)
			for i=1,num_lanes do
				if lane_effects[i] then
					draw_quad(lane_quad(i),lane_effects[i])
				end
			end
		end
		build_draw_list()
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
end
