tempest_logo,tempest_logo_outline={},{}

function init_tempest_logo()
	for i=0,7 do
		local s=unpack_shape(V_TEMPEST_LOGO1+i)
		add(tempest_logo,s)
		add(tempest_logo_outline,{verts=s.verts,cmds=unpack_cmds(cmds_data[C_TEMPEST_LOGO_OUTLINE1+i])})
	end
end

function draw_tempest_logo(x,y,w,col,outline)
	local s=w/120
	local m={s,0,x,0,s,y}
	for logo in all(outline and tempest_logo_outline or tempest_logo) do
		logo.cmds[1][2]=col or 7
		gpu_draw(logo,m)
	end
end
