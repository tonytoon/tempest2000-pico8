-- waves are the definitions of how enemies are spawned into stages.

function init_wave(wave)
	for g in all(wave.generators) do
		g.timer=flr(g.period/2)
	end
end

function do_wave()
	local wave=game_active_web.wave

	if wave.total_enemies<=0 then
		return
	end

	for g in all(wave.generators) do
		g.timer-=1
		if g.timer<0 and wave.total_enemies>0 then
			if g.type!=SPIKER or not game_spiker_active then
				spawn_object(g.type)
			end
			g.timer=g.period
			wave.total_enemies-=1
		end
	end
end