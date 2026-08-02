-- tempest 2000 selects the final 32 entries in yak.s raw_webs
-- and repeats them after stage 32.

spikes={}
game_active_web={}

-- cached projected web geometry used by rendering
near_buf={}
far_buf={}
near_shape={verts=near_buf}
far_shape={verts=far_buf}
web_spokes={verts={},cmds={}}

function init_vert_buf(buf,size)
	for i=1,#buf do buf[i]=nil end
	for i=1,size do buf[i]={0,0} end
end

function init_web_spokes()
	local vertex_count=#game_active_web.shape.verts
	web_spokes.verts={}
	web_spokes.cmds={{cmd_col,COL_WEB_SPOKES}}
	for i=1,vertex_count do add(web_spokes.verts,near_buf[i]) end
	for i=1,vertex_count do
		add(web_spokes.verts,far_buf[i])
		add(web_spokes.cmds,{cmd_opn,i,i+vertex_count})
	end
end

function update_view()
	local clip_z=camera_z+camera_near
	web_visible=clip_z<web_far_z
	if not web_visible then return end
	for i=1,#game_active_web.near_verts do
		local near_vertex=game_active_web.near_verts[i]
		local far_vertex=game_active_web.far_verts[i]
		local t=mid(
			0,
			(clip_z-near_vertex[3])/(far_vertex[3]-near_vertex[3]),
			1
		)
		local z=max(near_vertex[3],clip_z)
		near_buf[i][1],near_buf[i][2]=project_world(
			lerp(near_vertex[1],far_vertex[1],t),
			lerp(near_vertex[2],far_vertex[2],t),
			z
		)
		far_buf[i][1],far_buf[i][2]=project_world(
			far_vertex[1],far_vertex[2],far_vertex[3]
		)
	end
end

function draw_web()
	if not game_outline_visible then return end
	gpu_draw(near_shape)
	gpu_draw(far_shape)
	web_spokes.cmds[1][2]=oneup_timer>0 and 15 or COL_WEB_SPOKES
end

function lane_quad(lane_number)
	local next_lane=lane_number%#far_buf+1
	return {
		near_buf[lane_number],near_buf[next_lane],
		far_buf[next_lane],far_buf[lane_number]
	}
end

function lane(pos)
	return min(flr(pos+1),game_active_web.lanes)
end

function sub_lane(pos)
	return pos%1
end

function snap_pos(pos)
	return flr(pos)+.5
end

function clamp_pos(pos)
	return game_active_web.closed and pos%num_lanes
		or mid(0,pos,num_lanes-0x0.0001)
end

function towards_pos(source,target,closed)
	local distance=target-source
	if closed then
		distance=(distance+num_lanes/2)%num_lanes-num_lanes/2
	end
	return distance<0 and -1 or distance>0 and 1 or 0
end

t2k_webs={
	V_WEB5,V_WEB11,V_WEB1,V_WEB2,V_WEB9,V_WEB3,V_WEB18,V_WEB19,
	V_WEB20,V_WEB4,V_WEB14,V_WEB10,V_WEB17,V_WEB6,V_WEB16,V_WEB22,
	V_WEB24,V_WEB23,V_WEB27,V_WEB25,V_WEB21,V_WEB28,V_WEB29,V_WEB30,
	V_WEB32,V_WEB33,V_WEB34,V_WEB35,V_WEB36,V_WEB37,V_WEB26,V_WEB31
}

function make_web(stage)
	-- packed web data contain vertices, commands, and meta data
	-- meta data is the number of lanes, which lane the player starts in
	-- as well as orientation data. orientation is basically the surface
	-- normal for each lane but hand-tuned to ensure objects point the right
	-- direction on webs which use mathematically suspect shapes (like the figure 8)

	local web = {}
	web.shape = { cmds={}, normals={} }

    web.wave = unpack_wave(waves_data[stage])

    local web_id=t2k_webs[(stage-1)%#t2k_webs+1]

    web.shape.verts = unpack_verts(verts_data[web_id])
    web.shape.cmds  = unpack_cmds(cmds_data[web_id])
    local web_meta  = unpack_web_meta(meta_data[web_id])

	web.lanes = web_meta.lanes
	
	web.start = web_meta.start
	web.closed = web_meta.closed

	-- we create an affine transform matrix for each lane that is used
	-- to make sure objects consistently point "up". some trial and error math
	-- was required to get the jaguar orientation data to work
	-- stuck with jag orientation data instead of generating my own because
	-- they already put in the work to make sure objects point the right way
	
	for n in all(web_meta.normals) do
		local m={1,0,0,0,1,0}
		set_affine(m,1,.5-n/256)
		add(web.shape.normals,m)         -- jag version represented angles as 256 units per turn
    end

	return web
end

function init_web(stage)
	game_active_web=make_web(stage)
	
	center_web(game_active_web)

	-- the web is represented as two sets of vertices, representing the near and far
	-- edges of the web/tunnel.

	game_active_web.near_verts={}
	game_active_web.far_verts={}

	local scale=4

	for v in all(game_active_web.shape.verts) do
	add(game_active_web.near_verts,{
		v[1]*scale,
		v[2]*scale,
		web_near_z
	})

	add(game_active_web.far_verts,{
		v[1]*scale,
		v[2]*scale,
		web_far_z
	})
	end

	num_lanes=game_active_web.lanes

	spikes={}
	init_vert_buf(near_buf,#game_active_web.shape.verts)
	init_vert_buf(far_buf,#game_active_web.shape.verts)
	init_web_spokes()

	near_shape.cmds=game_active_web.shape.cmds
	far_shape.cmds=game_active_web.shape.cmds
end

function center_web(web)
	for v in all(web.shape.verts) do
		v[1]=8-v[1]
		v[2]=8-v[2]
	end
end
