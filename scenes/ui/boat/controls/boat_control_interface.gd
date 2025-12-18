class_name BoatControllerInterface
extends Control

@onready var leme_anchor: Control = $LemeAnchor

func _ready() -> void:
	GlobalSignalBus.direction_changed.connect(_rotate_leme)
	GlobalSignalBus.rotation_changed.connect(_update_compass)


func _update_compass(boat_rotation: float) -> void:
	RenderingServer.global_shader_parameter_set(
		&"compass_direction", boat_rotation)


func _rotate_leme(direction: float) -> void:
	var dir_deg: float = direction * -45
	var t: Tween = get_tree().create_tween()
	t.tween_property(leme_anchor, ^"rotation_degrees", dir_deg, 0.2)
