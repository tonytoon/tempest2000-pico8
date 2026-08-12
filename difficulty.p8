-- tempest 2000 stage difficulty
-- values in this file are indexed or calculated from the current stage.


-- populated from the object attribute data during init_spawn_data()
enemy_zspeeds={}

function enemy_zspeed_for_stage(type,stage)
	local speeds=enemy_zspeeds[type]
	if not speeds then return end
	return @(speeds+min((stage-1)\2,49))/128
end


function powerup_delay_for_stage(stage)
	return @(CURVE_POWERUP_DELAY+min((max(1,stage)-1)\2,49))
end

function enemy_shot_limit_for_stage(stage)
	return min((stage-1)\8+1,4)
end

function flipper_pause_for_stage(stage)
	return @(CURVE_FLIPPER_PAUSE+min((max(1,stage)-1)\2,49))
end

function fuse_cross_delay_for_stage(stage)
	return @(CURVE_FUSE_CROSS_DELAY+min((max(1,stage)-1)\2,49))
end

function pulsar_deadliness_for_stage(stage)
	return @(CURVE_PULSAR_DEADLINESS+min((max(1,stage)-1)\2,49))
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
	return values
end

--$switch-compiler: none
