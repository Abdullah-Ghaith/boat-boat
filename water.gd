# Attach to the Water MeshInstance3D.
# Pushes the shared clock AND all wave parameters to the shader
# every frame, so inspector changes to WaterManager take effect live.

extends MeshInstance3D

func _process(_delta):
	var mat := get_active_material(0)
	if not mat:
		return

	# sync clock
	mat.set_shader_parameter("time", WaterManager.time)

	# sync all wave params — change any @export on WaterManager and
	# it reflects here on the next frame, no restart needed
	mat.set_shader_parameter("w1_freq",  WaterManager.w1_freq)
	mat.set_shader_parameter("w1_speed", WaterManager.w1_speed)
	mat.set_shader_parameter("w1_amp",   WaterManager.w1_amp)

	mat.set_shader_parameter("w2_freq",  WaterManager.w2_freq)
	mat.set_shader_parameter("w2_speed", WaterManager.w2_speed)
	mat.set_shader_parameter("w2_amp",   WaterManager.w2_amp)
	mat.set_shader_parameter("w2_cross", WaterManager.w2_cross)

	mat.set_shader_parameter("w3_freq",  WaterManager.w3_freq)
	mat.set_shader_parameter("w3_freqy", WaterManager.w3_freqy)
	mat.set_shader_parameter("w3_speed", WaterManager.w3_speed)
	mat.set_shader_parameter("w3_amp",   WaterManager.w3_amp)

	mat.set_shader_parameter("w4_freq",  WaterManager.w4_freq)
	mat.set_shader_parameter("w4_freqy", WaterManager.w4_freqy)
	mat.set_shader_parameter("w4_speed", WaterManager.w4_speed)
	mat.set_shader_parameter("w4_amp",   WaterManager.w4_amp)
