-- renderer for vector shapes
-- this went through a lot of changes. for a while it worked very close to a real gpu
-- with vertex and index buffers, but that ran up against limitations of pico-8's memory
-- management overhead (and token limit) so back to a simpler model but I left it named
-- gpu because it feels fancy

-- gpu_draw() is the main rendering function. it takes a shape and an optional affine
-- transform matrix. the shape is a table with a vertices array and a commands array.
-- commands take parameters which are evaluated either immediately (cmd_col) or as a
-- vertex index into the shape's vertices array (cmd_pnt, cmd_opn, cmd_cls,
-- cmd_pol, cmd_tri).

-- commands
--[[const]] cmd_col  = -1 -- set color
--[[const]] cmd_pnt  = -3 -- draw point at vertex
--[[const]] cmd_opn  = -4 -- draw open polyline through vertices
--[[const]] cmd_cls  = -5 -- draw closed polygon through vertices
--[[const]] cmd_pol  = -7 -- draw shaded polygon composed of vertices
--[[const]] cmd_tri  = -8 -- draw filled triangle through three vertices

-- draw a shape to screen with an optional affine transform matrix
function gpu_draw(shape,m,raw)
	local raw = raw or nil
	m=m or identity_mat
	local out={}
	for cmd in all(shape.cmds) do
		local op=cmd[1]
		if op==cmd_col then
			col=cmd[2]
		elseif op==cmd_pnt then
			for i=2,#cmd do
				local v=shape.verts[cmd[i]]
				apply_affine(m,v,out)
				if not raw then
					out[1],out[2]=aspect_point(out[1],out[2])
				end
				pset(out[1],out[2],col)
			end
		elseif op==cmd_opn or op==cmd_cls then
			local px,py,fx,fy
			for i=2,#cmd do
				local v=shape.verts[cmd[i]]
				apply_affine(m,v,out)
				if not raw then
					out[1],out[2]=aspect_point(out[1],out[2])
				end
				local x,y=out[1],out[2]
				if px then
					line(px,py,x,y,col)
				else
					fx,fy=x,y
				end
				px,py=x,y
			end
			if op==cmd_cls then line(px,py,fx,fy,col) end
		elseif op==cmd_tri then
			local v=shape.verts[cmd[2]]
			apply_affine(m,v,out)
			if not raw then
				out[1],out[2]=aspect_point(out[1],out[2])
			end
			local x0,y0=out[1],out[2]
			v=shape.verts[cmd[3]]
			apply_affine(m,v,out)
			if not raw then
				out[1],out[2]=aspect_point(out[1],out[2])
			end
			local x1,y1=out[1],out[2]
			v=shape.verts[cmd[4]]
			apply_affine(m,v,out)
			if not raw then
				out[1],out[2]=aspect_point(out[1],out[2])
			end
			p01_triangle_163(x0,y0,x1,y1,out[1],out[2],col)
		elseif op==cmd_pol then
			local vbuf = {}
			for i=2,#cmd do
				local v=shape.verts[cmd[i]]
				apply_affine(m,v,out)
				if not raw then
					out[1],out[2]=aspect_point(out[1],out[2])
				end
				add(vbuf,{out[1],out[2]})
			end
			polyfill(vbuf,col)
		end
	end
end

function gpu_text(str,x,y,s,sy,c,k,spacing)
	sy=sy or s
	c=c or COL_YELLOW
	k=k or 0
	local m={s,k,x+2*s,0,sy,y}

	for i=1,#str do
		local shape=shape_alpha[sub(str,i,i)]

		if shape then
			shape.cmds[1][2]=c
			gpu_draw(shape,m)
		end

		m[3]+=spacing or 5*s
	end
end

function draw_zap(p,d,p2,d2)
	local x,y=project(p,d)
	local x2,y2=project(p2,d2)
	if not x or not x2 then return end
	for i=1,8 do
		local nx,ny=lerp(x,x2,i/8)+rnd(5)-2,
			lerp(y,y2,i/8)+rnd(5)-2
		aline(x,y,nx,ny,COL_CYCLE_HOT)
		x,y=nx,ny
	end
	aline(x,y,x2,y2,COL_CYCLE_HOT)
end

-- aspect-correct wrappers for direct pset/line drawing
function aline(x1,y1,x2,y2,c)
	x1,y1=aspect_point(x1,y1)
	x2,y2=aspect_point(x2,y2)
	line(x1,y1,x2,y2,c)
end

function apset(x,y,c)
	x,y=aspect_point(x,y)
	pset(x,y,c)
end

-- polyfill with subpixel accuracy. used for objects such as lanes and shapes that are not
-- broken down into triangles. not optimal for triangles - that's why we have the second
-- function below.
-- sourced from https://github.com/freds72/picocad-client/blob/master/carts/poly.lua
function polyfill(v,c)
	color(c)
	local p0,spans=v[#v],{}
	local x0,y0=aspect_point(p0[1],p0[2])
	for i,p1 in inext,v do
		local x1,y1=aspect_point(p1[1],p1[2])
		local _x1,_y1=x1,y1
		if(y0>y1) x0,y0,x1,y1=x1,y1,x0,y0
		local dx=(x1-x0)/(y1-y0)
		local cy0=y0\1+1
		if(y0<0) x0-=y0*dx y0=0 cy0=0
		-- sub-pix shift
		x0+=(cy0-y0)*dx
		if(y1>127) y1=127
		for y=cy0,y1 do
			local span=spans[y]
			if span then
				rectfill(x0,y,span,y)
			else
				spans[y]=x0
			end
			x0+=dx
		end
		x0,y0=_x1,_y1
	end
end

--fast triangle fill. not the best, but very few tokens and we're more concerned
--with speed than quality.
--sourced from https://www.lexaloffle.com/bbs/?pid=74564
--@p01
function p01_triangle_163(x0,y0,x1,y1,x2,y2,col)
	color(col)
	if(y1<y0)x0,x1,y0,y1=x1,x0,y1,y0
	if(y2<y0)x0,x2,y0,y2=x2,x0,y2,y0
	if(y2<y1)x1,x2,y1,y2=x2,x1,y2,y1
	local split_x=x0+(x2-x0)/(y2-y0)*(y1-y0)
	p01_trapeze_h(x0,x0,x1,split_x,y0,y1)
	p01_trapeze_h(x1,split_x,x2,x2,y1,y2)
end

function p01_trapeze_h(l,r,lt,rt,y0,y1)
	lt,rt=(lt-l)/(y1-y0),(rt-r)/(y1-y0)
	if(y0<0)l,r,y0=l-y0*lt,r-y0*rt,0
	y1=min(y1,128)
	for y0=y0,y1 do
		rectfill(l,y0,r,y0)
		l+=lt
		r+=rt
	end
end
