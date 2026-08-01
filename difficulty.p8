-- tempest 2000 stage difficulty
-- values in this file are indexed or calculated from the current stage.


-- populated from the object attribute data during init_spawn_data()
enemy_zspeeds={}

function enemy_zspeed_for_stage(type,stage)
	local speeds=enemy_zspeeds[type]
	if not speeds then return end
	return @(speeds+min((stage-1)\2,49))/128
end

--$switch-compiler: parens8

function powerup_delay_for_stage(stage)
	local s=max(1,stage)
	if s<3 then
		return 4
	elseif s<5 then
		return 5
	elseif s<13 then
		return 6
	elseif s<17 then
		return 7
	elseif s<41 then
		return 8
	elseif s<49 then
		return 10
	else
		return 15
	end
end

function enemy_shot_limit_for_stage(stage)
	return min((stage-1)\8+1,4)
end

function flipper_pause_for_stage(stage)
	local s=max(1,stage)
	if s<17 then
		return 16
	elseif s<33 then
		return 8
	elseif s<49 then
		return 6
	elseif s<65 then
		return 5
	elseif s<81 then
		return 4
	elseif s<97 then
		return 3
	else
		return 2
	end
end

function fuse_cross_delay_for_stage(stage)
	local s=max(1,stage)
	if s<17 then
		return 8
	elseif s<33 then
		return 4
	elseif s<49 then
		return 3
	elseif s<65 then
		return 2
	else
		return 1
	end
end

function pulsar_deadliness_for_stage(stage)
	local s=max(1,stage)
	if s<9 then
		return 8
	elseif s<11 then
		return 7
	elseif s<13 then
		return 6
	elseif s<15 then
		return 5
	elseif s<17 then
		return 6
	elseif s<19 then
		return 5
	elseif s<21 then
		return 4
	elseif s<23 then
		return 3
	elseif s<25 then
		return 6
	elseif s<27 then
		return 5
	elseif s<29 then
		return 4
	elseif s<31 then
		return 3
	elseif s<33 then
		return 6
	elseif s<35 then
		return 5
	elseif s<37 then
		return 4
	elseif s<39 then
		return 3
	elseif s<41 then
		return 6
	elseif s<43 then
		return 5
	elseif s<45 then
		return 4
	elseif s<47 then
		return 3
	elseif s<49 then
		return 6
	elseif s<51 then
		return 5
	elseif s<53 then
		return 4
	elseif s<55 then
		return 3
	else
		return 3
	end
end

function wave_superflipper_chance(stage)
	return min(max(stage-17,0)*2,254)
end

function super_spike_chance(stage)
	return min(stage-1,127)*2
end

function tanker_superflip_chance(stage)
	return min(stage-1,63)*4
end

function superflipper3_chance(stage)
	return min(stage-1,127)*2
end

function stage_difficulty_for(stage,beastly)
	local values={}
	values.pup_delay_max=powerup_delay_for_stage(stage)
	values.enemy_shot_limit=beastly and 6 or enemy_shot_limit_for_stage(stage)
	values.flipper_pause=beastly and 1 or flipper_pause_for_stage(stage)
	values.fuse_cross_delay=beastly and 1 or fuse_cross_delay_for_stage(stage)
	values.pulsar_deadliness=pulsar_deadliness_for_stage(stage)
	values.wave_superflipper_chance=wave_superflipper_chance(stage)
	values.super_spike_chance=super_spike_chance(stage)
	values.tanker_superflip_chance=tanker_superflip_chance(stage)
	values.superflipper3_chance=superflipper3_chance(stage)
	return values
end

--$switch-compiler: none
