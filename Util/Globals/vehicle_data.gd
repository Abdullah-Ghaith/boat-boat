# res://data/vehicles/vehicle_data.gd
class_name VehicleData
extends Resource

## Unique key used in SaveData.unlocked_vehicles and as dictionary key
@export var id: StringName = &""

@export var display_name: String = ""
@export var description: String = ""

# --- Movement ---

@export var wheel_base = 45
@export var base_steering_angle = 15.0
@export var drift_steering_angle = 40.0
@export var base_engine_power = 1160
@export var friction = -55
@export var drift_friction = -75
@export var drag = -0.06
@export var braking = -450
@export var max_speed_reverse = 250
@export var slip_speed = 400
@export var traction_fast = 2.5
@export var traction_slow = 10
@export var drift_traction = 0.3
@export var drift_level_boosts = {
	Consts.DriftLevel.LEVEL_0 : 0,
	Consts.DriftLevel.LEVEL_1 : 250,
	Consts.DriftLevel.LEVEL_2 : 550,
	Consts.DriftLevel.LEVEL_3 : 800,
}

# --- Durability ---
@export var max_hp: int = 3                          # hits before destruction
@export var base_armor: int = 0                      # flat damage reduction

# --- Assets ---
@export var engine_sound: AudioStream
