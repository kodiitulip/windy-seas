@tool
class_name FloatyMarker3D
extends Marker3D

@export var float_force: float = 3.0
@export var water_level: float = 0.0

@export_group("Water Level Noise", "noise_level_")
@export_custom(PROPERTY_HINT_GROUP_ENABLE,"noise_level_") var noise_level_enable: bool = false
@export var noise_level_noise: NoiseTexture2D

var body: RigidBody3D
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity", 9.8)

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	body = _find_parent_body()
	if body.get_parent() == null:
		add_child(body)


func _find_parent_body() -> RigidBody3D:
	if owner is RigidBody3D:
		return owner as RigidBody3D
	if get_parent() is RigidBody3D:
		return get_parent() as RigidBody3D
	return RigidBody3D.new()


func _physics_process(_delta: float) -> void:
	if Engine.is_editor_hint() or not body:
		return
	var depth: float = _get_depth()
	if depth > 0:
		apply_buoyancy_force(depth)


func _get_depth() -> float:
	if not noise_level_enable:
		return water_level - global_position.y
	var noise: float = noise_level_noise.noise.get_noise_2dv(Vector2(
		global_position.x, global_position.z
	) * Time.get_ticks_msec())
	return water_level - global_position.y - noise


func apply_buoyancy_force(depth: float) -> void:
	var force: Vector3 = Vector3.UP * float_force * gravity * depth
	body.apply_force(force, global_position - body.global_transform.origin)


func _get_configuration_warnings() -> PackedStringArray:
	var war: Array[String] = []
	if get_parent() is not RigidBody3D:
		war.append("Floaty Markers are meant to be children of RigidBody3D's")
	return war
