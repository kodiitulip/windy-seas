class_name BoatControllerInterface
extends Control

signal speed_changed(speed_value: float)

@export var player_boat: BoatBody3D

@onready var speed_lever: VSlider = $SpeedLever
@onready var leme_anchor: Control = $LemeAnchor

func _ready() -> void:
	assert(player_boat is BoatBody3D, "No PlayerBoat found")
	GlobalSignalBus.direction_changed.connect(_rotate_leme)
	GlobalSignalBus.speed_changed.connect(_update_lever_value)


func _update_lever_value(value: float) -> void:
	pass


func _rotate_leme(direction: float) -> void:
	var dir_deg: float = direction * -45
	var t: Tween = get_tree().create_tween()
	t.tween_property(leme_anchor, ^"rotation_degrees", dir_deg, 0.2)
