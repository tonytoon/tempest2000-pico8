--$switch-compiler: packed_rom

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
		return "mouse,sensitivity,max lanes,flick jump,crt adjust,tate mode,web outline"
	elseif game_menu==M_DATA then
		return "high scores,reset data"
	end
	return "stage: "..game_stage.."  bonus: "..tostr(stage_select_bonus(game_stage),2)..",up/down: stage +/- 1,left/right: stage +/- 10"
end

function menu_y()
	return game_menu==M_MAIN and 84 or game_menu==M_STAGE_SELECT and 88 or 56
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
			local step=btnp(3) and 1 or -1
			menu_selection=menu_selection+step
			if not mouse_opts[1] and menu_selection>1 and menu_selection<5 then
				menu_selection=btnp(3) and 5 or 1
			elseif menu_selection<1 then
				menu_selection=7
			elseif menu_selection>7 then
				menu_selection=1
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
			elseif menu_selection==6 then
				tate_mode=(tate_mode+1)%4
				set_crt_adjust()
			elseif menu_selection==7 then
				game_outline_visible=not game_outline_visible
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
			print("\f7\142 delete \f6\151 cancel",28,116)
			return
		end
		if game_menu==M_MAIN then
			print(get_message(S_TITLE_CREDIT_1),0,64-adjust_y,COL_WHITE)
			print(get_message(S_TITLE_CREDIT_2),2,71-adjust_y,COL_WHITE)
			print(get_message(S_TITLE_CREDIT_3),0,78-adjust_y,COL_WHITE)
		end
	end

	draw_menu(menu_items(),menu_y())
	print("\142 to select \151 to return",12,122-adjust_y,COL_WHITE)
end

--$switch-compiler: none
