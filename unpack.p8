-- packed-data decoding is limited to setup and infrequent message lookup
--$switch-compiler: parens8

function unpack_addr(addr)
	addr+=1
	if @addr==0 then
		return (@(addr+1)|(@(addr+2)<<8))+1
	end
	return addr
end

function unpack_wave(addr)
	addr=unpack_addr(addr)

	local n=@addr
	local wave={
		total_enemies=@(addr+1),
		generators={}
	}

	addr+=2

    for i=1,n do
        add(wave.generators,{
            type=@addr,
            period=@(addr+1)|(@(addr+2)<<8)
        })
        addr+=3
    end

	return wave
end

function unpack_cmds(addr)
	addr=unpack_addr(addr)
	local end_addr=addr+@(addr-1)
	local cmds={}
	local cmd

	while addr<end_addr do
		local v=@addr
		addr+=1
		if v>=128 then
			cmd={v-256}
			add(cmds,cmd)
		else
			add(cmd,v)
		end
	end

	return cmds
end

function unpack_verts(addr)
	addr=unpack_addr(addr)

	local verts={}
	local n=@addr
	local delta=n>=128
	if delta then n-=128 end
	addr+=1

	if delta then
		local x,y=@addr,@(addr+1)
		if x>=128 then x-=256 end
		if y>=128 then y-=256 end
		add(verts,{x,y})
		addr+=2

		for i=2,n do
			local d=@addr
			local dx,dy=d&0xf,d\16
			if dx>=8 then dx-=16 end
			if dy>=8 then dy-=16 end
			x+=dx
			y+=dy
			add(verts,{x,y})
			addr+=1
		end
	else
		for i=1,n do
			local x,y=@addr,@(addr+1)
			if x>=128 then x-=256 end
			if y>=128 then y-=256 end
			add(verts,{x,y})
			addr+=2
		end
	end

	return verts
end

function unpack_shape(i)
	return{verts=unpack_verts(verts_data[i]),cmds=unpack_cmds(cmds_data[i])}
end

function unpack_web_meta(addr)
	addr=unpack_addr(addr)

	local meta={
		lanes=@addr,
		start=@(addr+1),
		closed=@(addr+2)~=0,
		normals={}
	}

	addr+=3

	for i=1,meta.lanes do
		local n=@addr

		if n>=128 then
			n-=256
		end

		add(meta.normals,n)
		addr+=1
	end

	return meta
end

--$switch-compiler: none
