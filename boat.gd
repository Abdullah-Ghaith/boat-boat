# Arcade boat controller

extends Node

@export var player        : CharacterBody3D = null
@export var max_speed     := 12.0
@export var accel         := 8.0
@export var turn_speed    := 2.0
@export var tilt_strength := 1.0
@export var tilt_smooth   := 4.0
@export var probe_span    := 1.5
@export var float_offset  := 0.37   # updated default to match new wave amplitudes

var forward_speed := 0.0
var heading       := 0.0

func _physics_process(delta):
	# 1. arcade steering
	var throttle := Input.get_axis("reverse", "forward")
	var steer    := Input.get_axis("turn_right", "turn_left")

	forward_speed  = move_toward(forward_speed, max_speed * throttle, accel * delta)
	heading       += steer * turn_speed * delta * clamp(forward_speed / max_speed, 0.0, 1.0)

	var dir := Vector3(sin(heading), 0, cos(heading))
	player.velocity = dir * forward_speed
	player.move_and_slide()

	# 2. sample hull footprint
	var p    := player.global_position
	var fwd  := Vector2(dir.x, dir.z) * probe_span
	var side := Vector2(dir.z, -dir.x) * probe_span
	var xz   := Vector2(p.x, p.z)

	var hf := WaterManager.get_height(xz + fwd)
	var hb := WaterManager.get_height(xz - fwd)
	var hr := WaterManager.get_height(xz + side)
	var hl := WaterManager.get_height(xz - side)

	# 3. snap height
	player.global_position.y = (hf + hb + hr + hl) * 0.25 + float_offset

	# 4. tilt to wave slope
	var pitch  := atan2(hb - hf, probe_span * 2.0) * tilt_strength
	var roll   := atan2(hl - hr, probe_span * 2.0) * tilt_strength
	var target := Basis.from_euler(Vector3(pitch, heading, roll))
	player.transform.basis = player.transform.basis.slerp(target, tilt_smooth * delta).orthonormalized()
