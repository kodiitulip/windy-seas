class_name BoatControllerInterface
extends Control

signal speed_changed(speed_value: float)

@export var player_boat: BoatBody3D

@onready var speed_lever: VSlider = $SpeedLever
@onready var leme_anchor: Control = $LemeAnchor

func _ready() -> void:
	if not player_boat:
		printerr("No PlayerBoat found")
	
	speed_lever.value_changed.connect(_on_speed_lever_value_changed)
	GlobalSignalBus.direction_changed.connect(_rotate_leme)


func _on_speed_lever_value_changed(value: float) -> void:
	speed_changed.emit(value)


func _rotate_leme(direction: float) -> void:
	var dir_deg: float = direction * 90
	var rotat: float = clampf(leme_anchor.rotation_degrees + dir_deg, -45, 45)
	var t: Tween = get_tree().create_tween()
	t.tween_property(leme_anchor, ^"rotation_degrees", rotat, 0.2)
