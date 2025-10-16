class_name BoatControllerInterface
extends Control

signal speed_changed(speed_value: float)

@export var player_boat: BoatBody3D

@onready var speed_lever: VSlider = $SpeedLever

func _ready() -> void:
	if not player_boat:
		printerr("No PlayerBoat found")
	
	speed_lever.value_changed.connect(_on_speed_lever_value_changed)


func _on_speed_lever_value_changed(value: float) -> void:
	speed_changed.emit(value)
