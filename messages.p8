
messages = {}

function add_message(id,x,y,duration,extra)
	local text=get_message(id)

	local msg={
		x or 192,
		y or 80,
		duration or 100,
		extra or 50,
		text
	}

	msg[3]+=msg[4]
	messages={msg}
end

--$switch-compiler: packed_rom

function show_messages()
	for m in all(messages) do
		m[3]-=1
		if m[3]<=0 then
			del(messages,m)
		end

		local y,a=m[2]+32,split(m[5],"|")
		local l=0
        for s in all(a) do
            l=max(l,#s)
        end
        local z=120/(5*l-1)
		local k=z*(abs((game_world_tics*2)%256-127)-63)/128
		local sy=z*min(1,m[3]/20)

		y-=4*z*(#a-1)

		for s in all(a) do
			local x=64-(5*#s-1)*z/2
			gpu_text(s,x,y,z,sy,nil,k)
			y+=8*z
		end
	end
end
--$switch-compiler: none
