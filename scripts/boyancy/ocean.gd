@tool
class_name OceanMultiMeshInstance3D
extends MultiMeshInstance3D

const OCEAN_WAVES_SHADER: ShaderMaterial = preload("uid://deplp1k0qessb")

@export var water_height: float = 0.0
@export var ocean_size: Vector2i = Vector2i.ONE:
	set(v):
		if v.length() == 0:
			v = Vector2i.ONE
		ocean_size = v
		_update_multimesh()
@export var ocean_tile_size: Vector2 = Vector2.ONE * 64:
	set(v):
		ocean_tile_size = v
		(multimesh.mesh as PlaneMesh).size = ocean_tile_size
@export var mesh_material: ShaderMaterial = OCEAN_WAVES_SHADER
@export_tool_button("Generate Multimesh",
	"Curve3D") var e: Callable = _update_multimesh

static var ocean: OceanMultiMeshInstance3D

func _enter_tree() -> void:
	if ocean and ocean != self:
		return
	ocean = self


func _exit_tree() -> void:
	if ocean == self:
		ocean = null


func _ready() -> void:
	_setup()
	_update_multimesh()


func _setup() -> void:
	if multimesh and multimesh.mesh:
		multimesh.changed.connect(_update_multimesh)
		multimesh.mesh.changed.connect(_update_multimesh)
		return
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
	multimesh.changed.connect(_update_multimesh)
	multimesh.mesh.changed.connect(_update_multimesh)


func _update_multimesh() -> void:
	multimesh.instance_count = ocean_size.x * ocean_size.y
	var pos_x: float
	var pos_z: float
	var offset_x: float
	var offset_y: float
	for id: int in multimesh.instance_count:
		offset_x = (ocean_tile_size.x / 2.0) - ocean_tile_size.x * \
				(ocean_size.x / 2.0)
		offset_y = (ocean_tile_size.y / 2.0) - ocean_tile_size.y * \
				(ocean_size.y / 2.0)
		
		pos_x = ((id % ocean_size.x) * ocean_tile_size.x)\
				+ offset_x
		pos_z = (floori(float(id) / ocean_size.x) % ocean_size.y)\
			* ocean_tile_size.y + offset_y
		
		var pos: Vector3 = Vector3(pos_x, water_height, pos_z)
		multimesh.set_instance_transform(id, Transform3D(Basis(), pos))


func _validate_property(property: Dictionary) -> void:
	if property.get("name") in ["ocean_size", "ocean_tile_size"]:
		property.set("hint", PROPERTY_HINT_LINK)
