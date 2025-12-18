@tool
class_name TopLevelFollowerNode3D
extends Node3D

var parent: Node3D

func _ready() -> void:
	top_level = true
	assert(get_parent() is Node3D, "TopLevelFollowerNode3D must be child of Node3D")
	parent = get_parent() as Node3D


func _physics_process(_delta: float) -> void:
	if not top_level:
		top_level = true
	if not parent:
		return
	global_position = parent.global_position
	global_position.y = maxf(global_position.y, -0.5)
	rotation_degrees.y = -parent.rotation_degrees.y
