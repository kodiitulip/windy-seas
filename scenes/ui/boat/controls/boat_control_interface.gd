class_name BoatControllerInterface
extends Control

@onready var speed_lever: VSlider = $SpeedLever
@onready var leme_anchor: Control = $LemeAnchor

func _ready() -> void:
	GlobalSignalBus.direction_changed.connect(_rotate_leme)
	GlobalSignalBus.speed_changed.connect(_update_lever_value)


func _update_lever_value(value: float, max_speed: float) -> void:
	speed_lever.max_value = max_speed
	speed_lever.min_value = -max_speed
	speed_lever.value = value


func _rotate_leme(direction: float) -> void:
	var dir_deg: float = direction * -45
	var t: Tween = get_tree().create_tween()
	t.tween_property(leme_anchor, ^"rotation_degrees", dir_deg, 0.2)
