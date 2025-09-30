@tool
class_name OceanMeshInstance3D
extends MeshInstance3D

const OCEAN_WAVES_SHADER: ShaderMaterial = preload("uid://duolc8ueunraj")

@export var ocean_waves: OceanWaves = OceanWaves.new()
@export var ocean_size: Vector2 = Vector2.ONE * 128:
	set(value):
		ocean_size = value
		(mesh as PlaneMesh).size = value

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity", 9.8)

static var ocean: OceanMeshInstance3D
var material: ShaderMaterial

func _enter_tree() -> void:
	if ocean and ocean != self:
		ocean_waves = ocean.ocean_waves
		return
	ocean = self


func _exit_tree() -> void:
	if ocean == self:
		ocean = null


func _ready() -> void:
	var m: PlaneMesh = PlaneMesh.new()
	m.size = ocean_size
	m.subdivide_width = floor(m.size.x / 2)
	m.subdivide_depth = floor(m.size.y / 2)
	m.material = OCEAN_WAVES_SHADER
	material = m.material
	mesh = m


func _process(_delta: float) -> void:
	_update_shader_params()


func _update_shader_params() -> void:
	material.set_shader_parameter("waves", ocean_waves.params)
	material.set_shader_parameter("waves_dir", ocean_waves.directions)


func _get_gerstner_wave_height(wave: Vector3, wave_dir: Vector2,
		pos: Vector3, time: float) -> float:
	var amplitude: float = wave.x
	var steepness: float = wave.y
	var wavelength: float = wave.z
	var k: float = 2.0 * PI / wavelength
	var c: float = sqrt(gravity / k)
	var d: Vector2 = wave_dir.normalized()
	var f: float = k * (d.dot(Vector2(pos.x, pos.z)) - c * time)
	var a: float = steepness / k
	return amplitude * a * sin(f)


func get_water_height(pos: Vector3) -> float:
	var height: float = 0.0
	for i: int in len(ocean_waves.params):
		height += _get_gerstner_wave_height(
			ocean_waves.params[i],
			ocean_waves.directions[i], pos, Time.get_ticks_msec()
		)
	return height
