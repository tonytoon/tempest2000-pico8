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

	local cmds={}
	local n=@addr
	addr+=1

	for i=1,n do
		local cmd={}
		local op=@addr
		local count=@(addr+1)

		if op>=128 then op-=256 end
		add(cmd,op)

		for j=1,count do
			local v=@(addr+1+j)
			if v>=128 then v-=256 end
			add(cmd,v)
		end

		add(cmds,cmd)
		addr+=2+count
	end

	return cmds
end

function unpack_verts(addr)
	addr=unpack_addr(addr)

	local verts={}
	local n=@addr
	addr+=1

	for i=1,n do
		local x=@addr
		local y=@(addr+1)

		if x>=128 then x-=256 end
		if y>=128 then y-=256 end

		add(verts,{x,y})
		addr+=2
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
