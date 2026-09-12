extends Node

# All wave parameters are exported so you can edit them at runtime
# in the Remote inspector while the game is running, change a value
# here and water_node.gd pushes it to the shader automatically.
#
# The GDScript get_height() and the shader wave_height() run the
# same math, so the boat always floats on what you can see.

var time       := 0.0
var time_offset := 0.0

# --- Wave 1: dominant long swell ---
@export var w1_freq  := 0.05
@export var w1_speed := 0.70
@export var w1_amp   := 0.45

# --- Wave 2: cross-swell ---
@export var w2_freq  := 0.45
@export var w2_speed := 0.55
@export var w2_amp   := 0.695
@export var w2_cross := 0.15   # mixes x into y phase,  breaks up grid regularity

# --- Wave 3: medium chop ---
@export var w3_freq  := 0.90
@export var w3_freqy := 0.60
@export var w3_speed := 1.60
@export var w3_amp   := 0.05

# --- Wave 4: fine surface ripple ---
@export var w4_freq  := 1.70
@export var w4_freqy := 1.30
@export var w4_speed := 2.10
@export var w4_amp   := 0.02

func _process(delta):
	time += delta

func get_height(world_pos: Vector2) -> float:
	var p := world_pos
	var t := time + time_offset
	var h := 0.0
	h += sin(p.x * w1_freq  + t * w1_speed) * w1_amp
	h += sin(p.y * w2_freq  - t * w2_speed  + p.x * w2_cross) * w2_amp
	h += sin((p.x * w3_freq + p.y * w3_freqy) + t * w3_speed) * w3_amp
	h += sin((p.x * w4_freq - p.y * w4_freqy) - t * w4_speed) * w4_amp
	return h
