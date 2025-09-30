@tool
@icon("uid://c71drpb8o4prn")
class_name ThirdPersonPCamController3D
extends Node

@export var mouse_sensitivity: float = 0.20

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


func _third_person_camera_movement(event: InputEventMouseMotion) -> void:
	var moviment: Vector2 = event.relative
	var pcam_rotation: Vector3 = pcam.get_third_person_rotation_degrees()
	pcam_rotation.x -= moviment.y * mouse_sensitivity
	pcam_rotation.x = clampf(pcam_rotation.x, -89, 20)
	pcam_rotation.y -= moviment.x * mouse_sensitivity
	pcam_rotation.y = wrapf(pcam_rotation.y, 0, 360)
	pcam.set_third_person_rotation_degrees(pcam_rotation)
	get_viewport().set_input_as_handled()


func _get_configuration_warnings() -> PackedStringArray:
	var war: Array[String] = []
	if get_parent() is not PhantomCamera3D:
		war.append(
			"ThirdPersonPCamController3D must be a child of PhantomCamera3D")
	return war
