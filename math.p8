-- affine, vector, and world-projection helpers

identity_mat={1,0,0,0,1,0}
scratch_mat={}

function lerp(a,b,t)
	return a+(b-a)*t
end

function approach(value,target,step)
	return mid(value-step,target,value+step)
end

-- apply a 2d affine transform to a vertex
function apply_affine(m,v,out)
	local x=v[1]
	local y=v[2]

	out[1]=x*m[1]+y*m[2]+m[3]
	out[2]=x*m[4]+y*m[5]+m[6]
end

-- set a 2d affine transform using pico-8's 0...1 rotation convention
function set_affine(m,sx,a,x,y,sy)
	sx=sx or 1
	sy=sy or sx
	a=a or 0
	x=x or 0
	y=y or 0

	local ca=cos(a)
	local sa=sin(a)

	m[1]= ca*sx
	m[2]=-sa*sy
	m[3]= x

	m[4]= sa*sx
	m[5]= ca*sy
	m[6]= y
end

function mul_affine(dst,a,b)
	local a11,a12,atx=a[1],a[2],a[3]
	local a21,a22,aty=a[4],a[5],a[6]

	local b11,b12,btx=b[1],b[2],b[3]
	local b21,b22,bty=b[4],b[5],b[6]

	dst[1]=a11*b11+a12*b21
	dst[2]=a11*b12+a12*b22
	dst[3]=a11*btx+a12*bty+atx

	dst[4]=a21*b11+a22*b21
	dst[5]=a21*b12+a22*b22
	dst[6]=a21*btx+a22*bty+aty
end

-- outline an already-projected web lane
function draw_quad(v,col)
	for i=1,4 do
		local a,b=v[i],v[i%4+1]
		aline(a[1],a[2],b[1],b[2],col)
	end
end

function project_camera(x,y,z)
	local s=camera_world_scale*camera_focal/z
	return 64+x*s,camera_cy+y*s,z
end

-- this works well enough for real 3D depth/camera but need
-- to flesh out more for rotations/yaw/etc.
function project_world(x,y,z)
	x-=camera_x
	y-=camera_y
	z-=camera_z
	if z<camera_near then return end
	return project_camera(x,y,z)
end

function draw_world_line(ax,ay,az,bx,by,bz,col)
	ax-=camera_x ay-=camera_y az-=camera_z
	bx-=camera_x by-=camera_y bz-=camera_z
	if az<camera_near and bz<camera_near then return end
	if az<camera_near then
		local t=(camera_near-az)/(bz-az)
		ax=lerp(ax,bx,t) ay=lerp(ay,by,t) az=camera_near
	elseif bz<camera_near then
		local t=(camera_near-bz)/(az-bz)
		bx=lerp(bx,ax,t) by=lerp(by,ay,t) bz=camera_near
	end
	local x1,y1=project_camera(ax,ay,az)
	local x2,y2=project_camera(bx,by,bz)
	aline(x1,y1,x2,y2,col)
end

-- project world web coordinates to screen coordinates
-- takes position on the web (lane-space) and depth in the web
-- we draw a line between the near and far edges of the web which intersects
-- the given position, and use the depth to determine distance along that line

function web_point(pos,depth)
	local i,t=lane(pos),sub_lane(pos)
	local j=i%#game_active_web.near_verts+1

	local na=game_active_web.near_verts[i]
	local nb=game_active_web.near_verts[j]
	local fa=game_active_web.far_verts[i]
	local fb=game_active_web.far_verts[j]

	-- position along the near lane edge
	local nx=lerp(na[1],nb[1],t)
	local ny=lerp(na[2],nb[2],t)
	local nz=lerp(na[3],nb[3],t)

	-- position along the far lane edge
	local fx=lerp(fa[1],fb[1],t)
	local fy=lerp(fa[2],fb[2],t)
	local fz=lerp(fa[3],fb[3],t)

	-- position along the web in world space
	local d=depth/160

	return
		lerp(nx,fx,d),
		lerp(ny,fy,d),
		lerp(nz,fz,d)
end

function project(pos,depth)
	local x,y,z=web_point(pos,depth)
	return project_world(x,y,z)
end
