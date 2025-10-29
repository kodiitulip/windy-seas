@tool
class_name OceanMultiMeshInstance3D
extends MultiMeshInstance3D

const OCEAN_WAVES_SHADER: ShaderMaterial = preload("uid://deplp1k0qessb")

@export var ocean_tile_size: Vector2 = Vector2.ONE * 64
@export var mesh_material: ShaderMaterial = OCEAN_WAVES_SHADER

static var ocean: OceanMultiMeshInstance3D

func _enter_tree() -> void:
	if ocean and ocean != self:
		return
	ocean = self


func _exit_tree() -> void:
	if ocean == self:
		ocean = null


func _ready() -> void:
	if multimesh and multimesh.mesh:
		return
	_setup()
	_update_multimesh()


func _setup() -> void:
	var mm: MultiMesh = MultiMesh.new()
	mm.transform_format = MultiMesh.TRANSFORM_3D
	var m: PlaneMesh = PlaneMesh.new()
	m.size = ocean_tile_size
	m.subdivide_width = floor(m.size.x * 2)
	m.subdivide_depth = floor(m.size.y * 2)
	mesh_material = OCEAN_WAVES_SHADER
	m.material = mesh_material
	mm.mesh = m
	multimesh = mm


func _update_multimesh() -> void:
	var trans: Transform3D = Transform3D()
	multimesh.instance_count = 1
	multimesh.set_instance_transform(0, trans)
