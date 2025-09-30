@tool
extends PhantomCamera3D

@export var mouse_sensitivity: float = 0.20

func _unhandled_input(event: InputEvent) -> void:
	var controlling: bool = Input.is_action_pressed(&"cam_control")
	if controlling and event is InputEventMouseMotion:
		_third_person_camera_movement(event as InputEventMouseMotion)


func _third_person_camera_movement(event: InputEventMouseMotion) -> void:
	var moviment: Vector2 = event.relative
	vertical_rotation_offset = clampf(
		vertical_rotation_offset - moviment.y * mouse_sensitivity,
		-85, -10
	)
	horizontal_rotation_offset -= moviment.x * mouse_sensitivity
