-- runtime initialization for font and special-purpose vector shapes
-- this runs once, so native code is smaller without affecting hot paths
--$switch-compiler: none

function init_shapes()
	shape_alpha={}
	local characters="ABCDEFGHIJKLMNOPQRSTUVWXYZ!1234567890"
	for i=1,#characters do
		shape_alpha[sub(characters,i,i)]=unpack_shape(V_CHAR_A+i-1)
	end

	spawn_data[MIRROR].ref_shape=unpack_shape(V_REFSHOT)
	zap_shape=unpack_shape(V_ZAP)
	score_shapes={}
	for i=0,5 do add(score_shapes,unpack_shape(V_SCORE_250+i)) end
	yes_shape=unpack_shape(V_YES)
end

--$switch-compiler: none
