@tool
@icon("uid://c71drpb8o4prn")
class_name ThirdPersonPCamController3D
extends Node

@export var mouse_sensitivity: float = 0.20
@export var zoom_sensitivity: float = 2.0
@export_group("Camera Limits", "camera")
@export_range(0.0, 360.0, 1.0, "radians_as_degrees") var camera_x_max: float = deg_to_rad(10)
@export_range(0.0, 360.0, 1.0, "radians_as_degrees") var camera_x_min: float = deg_to_rad(89)

var pcam: PhantomCamera3D

func _ready() -> void:
	if Engine.is_editor_hint(): return
	assert(get_parent() is PhantomCamera3D, 
			"ThirdPersonPCamController3D must be a child of PhantomCamera3D")
	pcam = get_parent() as PhantomCamera3D


func _unhandled_input(event: InputEvent) -> void:
	if Engine.is_editor_hint(): return
	var controlling: bool = Input.is_action_pressed(&"cam_control")
	if controlling and event is InputEventMouseMotion:
		_third_person_camera_movement(event as InputEventMouseMotion)
	var zoom_axis: float = Input.get_axis(&"cam_zoom_down", &"cam_zoom_up")
	if zoom_axis != 0:
		var spring_length: float = pcam.get_spring_length()
		pcam.set_spring_length(
			clampf(spring_length - zoom_axis * zoom_sensitivity, 6, 20))


func _third_person_camera_movement(event: InputEventMouseMotion) -> void:
	var moviment: Vector2 = event.relative
	var pcam_rotation: Vector3 = pcam.get_third_person_rotation()
	pcam_rotation.x -= deg_to_rad(moviment.y * mouse_sensitivity)
	pcam_rotation.x = clampf(pcam_rotation.x, -camera_x_min, -camera_x_max)
	pcam_rotation.y -= deg_to_rad(moviment.x * mouse_sensitivity)
	pcam_rotation.y = wrapf(pcam_rotation.y, deg_to_rad(0), deg_to_rad(360))
	pcam.set_third_person_rotation(pcam_rotation)
	get_viewport().set_input_as_handled()


func _get_configuration_warnings() -> PackedStringArray:
	var war: Array[String] = []
	if get_parent() is not PhantomCamera3D:
		war.append(
			"ThirdPersonPCamController3D must be a child of PhantomCamera3D")
	return war
