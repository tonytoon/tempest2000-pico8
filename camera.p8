-- camera settings are currently based on the jaguar origina
-- this will need tweaked to match the pico-8 screen and aspect ratio
--$switch-compiler: parens8

-- camera world position
camera_x=0
camera_y=-1
camera_z=-23
camera_cy=64
camera_view=0

-- projection
--[[const]] camera_focal=-64
--[[const]] camera_world_scale=2
--[[const]] object_world_scale=0.5
--[[const]] camera_near=8

-- jaguar camera behavior
--[[const]] camera_follow=.5
--[[const]] camera_speed=.25

-- web world depth
--[[const]] web_near_z=30
--[[const]] web_far_z=190

-- timed z movement
zoom_active=false
zoom_z_start=camera_z
zoom_z_target=camera_z
zoom_start_tic=0
zoom_duration=1

-- i mentally struggle with cameras in 3D space so i hope i don't have to
-- touch these again since i'm sure i'll forget how they work

function start_zoom(z,duration)
	zoom_z_start=camera_z
	zoom_z_target=z
	zoom_start_tic=game_world_tics
	zoom_duration=max(duration,1)
	zoom_active=true
end

function camera_view_z()
	if camera_view==1 then
		local m=0
		for v in all(game_active_web.near_verts) do
			m=max(m,max(abs(v[1]),abs(v[2]+1)))
		end
		return min(-23,30-m*32/15)
	end
	return camera_view==0 and -23 or -10
end

function update_camera(pos)
	local i,t=lane(pos),sub_lane(pos)
	local j=i%#game_active_web.near_verts+1

	local a=game_active_web.near_verts[i]
	local b=game_active_web.near_verts[j]

	local px=lerp(a[1],b[1],t)
	local py=lerp(a[2],b[2],t)

	local follow=camera_view==1 and 0 or camera_follow
	local tx=px*follow
	local ty=py*follow+(camera_view<2 and -1 or -2)

	camera_x=approach(camera_x,tx,camera_speed)
	camera_y=approach(camera_y,ty,camera_speed)
	camera_cy=approach(camera_cy,64,.25)

	if zoom_active then
		local t=mid(
			0,(game_world_tics-zoom_start_tic)/zoom_duration,1)

		camera_z=lerp(zoom_z_start,zoom_z_target,t)

		if t>=1 then
			camera_z=zoom_z_target
			zoom_active=false
		end
	end
end

--$switch-compiler: none

-- aspect ratio corrections for when displaying on crt
-- the misterfpga core that runs pico8 can output to a crt with a 4:3 aspect ratio,
-- which it does with some scaling and stretching. this code allows me to correct for the
-- visual distortion that creates.

display_aspect_x=1
display_aspect_y=1

function aspect_point(x,y)
	return
		64+(x-64)*display_aspect_x,
		64+(y-64)*display_aspect_y
end

function set_crt_adjust()
	poke(0x5f2c,tate_mode~=0 and tate_mode+132 or 0)
	display_aspect_x=crt_adjust and 3/4 or 1
	display_aspect_y=crt_adjust and 15/16 or 1
end