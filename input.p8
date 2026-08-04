-- input functions

function get_input()
	input_mouse_dx=mouse_opts[1] and -stat(38) or 0
	local mouse_buttons=mouse_opts[1] and stat(34) or 0

	input_dir=btn(0) and -1 or btn(1) and 1 or 0

	-- jump can be triggered by pressing down on the keyboard/controller, or
	-- by quickly moving the mouse up/down. it can also be activated by clicking the
	-- mouse wheel but i've not tested it yet.
	
	if btn(3)
		or (mouse_buttons&4)!=0
		or mouse_opts[1] and mouse_opts[4]>0
		and abs(stat(39))>=mouse_opts[4]*10 then
			start_jump()
	end

	if btnp(2) and game_state==G_ACTIVE then
		camera_view=(camera_view+1)%3
		start_zoom(camera_view_z(),30)
	end

	input_fire=btn(4) or (mouse_buttons&1)!=0
	input_super_zapper=btn(5) or (mouse_buttons&2)!=0
end