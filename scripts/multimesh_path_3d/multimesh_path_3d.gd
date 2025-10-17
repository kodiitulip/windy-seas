@tool
class_name MultiMeshPath3D
extends Path3D

@export var mesh: Mesh = preload("uid://b50kbehaggo63"):
	set = _set_mesh
@export var distance_between_mesh_instances: float = 1.0:
	set = _set_distance_between_mesh_instances
@export var align_instances_rotation: bool = true:
	set(value):
		align_instances_rotation = value
		curve_changed.emit()

var _multimesh: MultiMeshInstance3D


func _enter_tree() -> void:
	if _multimesh != null and not _multimesh in get_children(true):
		return
	_multimesh = MultiMeshInstance3D.new()
	_multimesh.multimesh = MultiMesh.new()
	_multimesh.multimesh.transform_format = MultiMesh.TRANSFORM_3D
	_multimesh.multimesh.mesh = mesh
	add_child.call_deferred(_multimesh)


func _ready() -> void:
	if not curve_changed.is_connected(_update_path_multimesh):
		curve_changed.connect(_update_path_multimesh)
	_update_path_multimesh()


func _update_path_multimesh() -> void:
	if not curve or not _multimesh:
		return
	var mm: MultiMesh = _multimesh.multimesh
	var path_length: float = curve.get_baked_length()
	var count: int = floor(path_length / distance_between_mesh_instances)
	
	mm.instance_count = count
	var instance_offset: float = distance_between_mesh_instances / 2.0
	
	for i: int in range(count):
		var inst_curve_distance: float = (instance_offset + 
			distance_between_mesh_instances * i)
		var inst_pos: Vector3 = curve.sample_baked(inst_curve_distance, true)
		var up: Vector3 = curve.sample_baked_up_vector(
			inst_curve_distance, true)
		var forward: Vector3 = inst_pos.direction_to(curve.sample_baked(
			inst_curve_distance + 0.1, true))
		var inst_basis: Basis = Basis(forward.cross(up).normalized(), 
			up, -forward) if align_instances_rotation else Basis()
		mm.set_instance_transform(i, Transform3D(inst_basis, inst_pos))


func _set_distance_between_mesh_instances(new_value: float) -> void:
	distance_between_mesh_instances = new_value
	curve_changed.emit()


func _set_mesh(new_value: Mesh) -> void:
	mesh = new_value
	_multimesh.multimesh.mesh = mesh
	curve_changed.emit()
