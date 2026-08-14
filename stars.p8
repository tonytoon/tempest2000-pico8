-- patterned starfield generators

-- generators and star allocation run only when a stage is initialized
--$switch-compiler: parens8

stars={}
blob={}
star_colors={COL_LIGHT_GREY,COL_BLUE,COL_CYAN}
star_speed=.01

function random_star()
	return rnd(2)-1,rnd(2)-1,rnd(1)
end

function spiral_star(i)
	local a,r=i*.382,(i%8+1)/8
	return cos(a)*r,sin(a)*r,i/64
end

function arms_star(i)
	local a,r=i/8,(i%8+1)/8
	return cos(a)*r,sin(a)*r,i/64
end

function tunnel_star(i)
	local a,r=i/64,.5+(i%2)/2
	return cos(a)*r,sin(a)*r,i/64
end

function init_stage_stars(stage)
	init_stars(({random_star,spiral_star,arms_star,tunnel_star})[(stage-1)%4+1])
end

function init_stars(generator)
	star_generator=generator or random_star
	star_speed=.01
	star_start_scale=(star_generator==spiral_star or star_generator==tunnel_star) and .35 or 0
	for i=1,64 do
		local x,y,z=star_generator(i)
		local c=i<=32 and COL_WHITE or star_colors[(i-33)%3+1]
		local scale=star_generator==random_star and 1 or min(1,star_start_scale+(1-z)*2)
		local q=(star_generator==spiral_star or star_generator==tunnel_star) and .1/sqrt(x*x+y*y) or 0
		stars[i]={x=x,y=y,z=z,c=c,scale=scale,
		sx=x*q,sy=y*q}
	end
end

--$switch-compiler: none

function update_stars()
	star_speed=.01+game_warp_speed/32
	for s in all(stars) do
		s.z-=star_speed
		if s.z<=.05 then
			if star_generator==random_star then
				s.x,s.y=rnd(2)-1,rnd(2)-1
			else
				s.scale=star_start_scale
			end
			s.z=1
		end
		if star_generator!=random_star then
			s.scale=min(1,s.scale+max(.02,star_speed))
		end
	end
end

function submit_stars()
	for s in all(stars) do
		local z=s.z+star_speed
		local x=s.sx+(s.x-s.sx)*s.scale
		local y=s.sy+(s.y-s.sy)*s.scale
		line(64+x/z*32,camera_cy+y/z*32,
			64+x/s.z*32,camera_cy+y/s.z*32,s.c)
	end
end

function draw_blobs()
	local t=game_world_tics/256
	for n=12,244,4 do
		blob[n]=sin(n/96+t)
	end
	for n=-110,238,4 do
		blob[n+512]=sin(n/88-t*1.3)+sin(n/49+t*.6)
	end
	for y=6,122,4 do
		for x=6,122,4 do
			if abs(x-64)+abs(y-64)>30 and blob[x+y]+blob[512+x*2-y]>1 then rectfill(x-2,y-2,x+1,y+1,COL_BLACK) end
		end
	end
end
