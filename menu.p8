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
				game_start_bonus=stage_select_bonus(game_stage)
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

	if game_menu==M_UPDATE and game_update_num>dget(48) then dset(48,game_update_num) end
	menu_move(accept)

	if btnp(5) and game_menu!=M_MAIN then
		menu_target=game_menu==M_INPUT and M_OPTIONS or M_MAIN
		menu_step=16
	elseif accept then
		menu_accept()
	end
end

function menu_items()
	if game_menu==M_MAIN then
		return "start,"..(game_beastly_unlocked and"beastly game,"or"").."options,whatsnew"
	elseif game_menu==M_OPTIONS then
		return "simple gfx,input,high scores,reset data"
	elseif game_menu==M_INPUT then
		return "mouse,sensitivity,flick jump,gsg spinner,sensitivity"
	elseif game_menu==M_UPDATE then
		return get_message(S_UPDATE)
	end
	return "stage: "..game_stage.."  bonus: "..tostr(stage_select_bonus(game_stage),2)..",up/down: stage +/- 1,left/right: stage +/- 10"
end

function menu_move(accept)
	if(game_menu==M_UPDATE)return
	local v=btnp(3)and 1 or btnp(2)and-1 or 0
	if game_menu==M_STAGE_SELECT then
		local d=btnp(2)and 1 or btnp(3)and-1 or btnp(0)and-10 or btnp(1)and 10 or 0
		game_stage=mid(1,game_stage+d,game_beastly and game_beastly_high_stage or (game_beastly_unlocked and game_stage_max or game_regular_high_stage))
		if(d!=0)init_stage_preview()
		return
	end
	if game_menu==M_OPTIONS and menu_selection==1 and (btnp(0)or btnp(1)or accept)then
		simple_gfx=not simple_gfx
		save_settings()
	elseif game_menu==M_INPUT then
		if v!=0 then
			repeat menu_selection=(menu_selection+v-1)%5+1
			until (mouse_opts[1]or menu_selection<2or menu_selection>3)
			and(mouse_opts[4]or menu_selection!=5)
		elseif btnp(0) or btnp(1) or accept then
			local d=btnp(0) and -1 or 1
			local i=menu_selection
			if i==1 or i==4 then
				mouse_opts[i]=not mouse_opts[i]
				if(i==1)poke(0x5f2d,mouse_opts[1]and 5or 0)
			else
				mouse_opts[i]=(mouse_opts[i]+d)%(i==3and 6or i==5and 8or 16)
			end
			save_settings()
		end
	elseif v!=0 then
		local n=#split(menu_items())
		menu_selection=(menu_selection+v-1)%n+1
	end
end

function menu_accept()
	if game_menu==M_OPTIONS and menu_selection==4 then
		reset_confirm=true
		return
	end
	menu_step=-16
	if game_menu==M_MAIN then
		local b=game_beastly_unlocked and 1 or 0
		game_beastly=b>0 and menu_selection==2
		menu_target=menu_selection<=1+b and M_STAGE_SELECT
			or menu_selection==2+b and M_OPTIONS or M_UPDATE
	elseif game_menu==M_STAGE_SELECT then
		menu_target=0
	elseif game_menu==M_OPTIONS then
		menu_target=menu_selection==2and M_INPUT
		if(menu_selection==3)data_scores=draw_scores
	elseif game_menu==M_UPDATE then
		menu_target=M_MAIN
	end
end


function draw_menu_state()
	if data_scores then data_scores() return end
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
			print(get_message(S_TITLE_CREDIT_1),0,64,COL_WHITE)
			print(get_message(S_TITLE_CREDIT_2),2,71,COL_WHITE)
			print(get_message(S_TITLE_CREDIT_3),0,78,COL_WHITE)
		end
	end

	draw_menu(menu_items(),game_menu==M_MAIN and 80or game_menu==M_STAGE_SELECT and 88or 56)
	print("\142 to select \151 to return",12,122,COL_WHITE)
end

--$switch-compiler: none
