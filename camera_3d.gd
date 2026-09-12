extends Camera3D

@export var target: Node3D
@export var distance := 14.0
@export var height := 8.0
@export var follow_speed := 3.0

func _process(delta):
	if not target: return
	var desired := target.global_position + Vector3(0, height, distance)
	global_position = global_position.lerp(desired, follow_speed * delta)
	look_at(target.global_position, Vector3.UP)
