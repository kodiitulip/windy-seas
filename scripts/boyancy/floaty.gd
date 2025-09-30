@tool
class_name FloatyMarker3D
extends Marker3D

@export var float_force: float = 3.0

var ocean: OceanMeshInstance3D
var body: RigidBody3D
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity", 9.8)

func _ready() -> void:
	ocean = OceanMeshInstance3D.ocean
	assert(owner is RigidBody3D, "Floaty markers must be children of RigidBody3D's")
	body = owner as RigidBody3D


func _physics_process(_delta: float) -> void:
	if Engine.is_editor_hint() or not ocean or not body:
		return
	var water_height: float = ocean.get_water_height(global_position)
	var depth: float = water_height - global_position.y
	if depth > 0:
		apply_buoyancy_force(depth)


func apply_buoyancy_force(depth: float) -> void:
	var force: Vector3 = Vector3.UP * float_force * gravity * depth
	body.apply_force(force, global_position - body.global_transform.origin)


func _get_configuration_warnings() -> PackedStringArray:
	var war: Array[String] = []
	if get_parent() is not RigidBody3D:
		war.append("Floaty Markers are meant to be children of RigidBody3D's")
	return war
