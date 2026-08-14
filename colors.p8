--colors
--$switch-compiler: parens8

--[[
COLOR 0  = black
COLOR 1  = grey
COLOR 2  = light grey
COLOR 3  = white
COLOR 4  = yellow
COLOR 5  = cyan
COLOR 6  = green
COLOR 7  = red
COLOR 8  = blue
COLOR 9  = flipper
COLOR 10 = flipper accent
COLOR 11 = web spokes
COLOR 12 = web 1
COLOR 13 = web 2
COLOR 14 = cycle cool
COLOR 15 = cycle hot
]]--

palettes={
 {0,5,6,7,10,131,11,8,1,8,128,12,1,129}, 		-- webs 1 - 16
 {0,5,6,7,10,131,11,8,1,140,12,8,130,2}, 		-- webs 17 - 32
 {0,5,6,7,10,131,11,8,1,135,138,135,13,141}, 	-- webs 33 - 48
 {0,5,6,7,10,131,11,8,1,131,139,3,0,128}, 		-- webs 49 - 64
 {0,5,6,7,10,131,11,8,1,7,138,14,5,134}, 		-- webs 65 - 80
 {0,5,6,7,10,131,11,8,1,9,10,14,0,0}, 			-- webs 81 - 96
 {0,5,6,7,10,131,11,8,1,136,14,11,0,0} 			-- webs 97 - 99
}

function init_palette(p)
	web_fill=p[13]+p[14]>0
	for i=0,13 do pal(i,p[i+1],1) end
end

-- physical colors used by the two animated logical colors
cycle_cols_hot={10,9,8,2,12,11,10}
cycle_cols_cool={12,7,14,7,12,13,14,7}

function cycle_palette(t)
	local count=#cycle_cols_hot
	pal(COL_CYCLE_COOL,cycle_cols_cool[t%count+1],1)
	pal(COL_CYCLE_HOT,cycle_cols_hot[t%count+1],1)
	--local a,b=web_col_a,web_col_b
	--if t%16>=8 then a,b=b,a end
	--pal(COL_WEB1,a,1)
	--pal(COL_WEB2,b,1)
end

--$switch-compiler: none
