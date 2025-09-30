class_name OceanMeshInstance3D
extends MeshInstance3D

@export var ocean_waves: Array[OceanWaves]

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity", 9.8)

static var ocean: OceanMeshInstance3D

func _enter_tree() -> void:
	if ocean and ocean != self:
		queue_free()
	ocean = self


func _exit_tree() -> void:
	if ocean == self:
		ocean = null


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
	for wave: OceanWaves in ocean_waves:
		height += _get_gerstner_wave_height(
			Vector3(wave.amplitude, wave.steepness, wave.wavelength),
			wave.direction, pos, Time.get_ticks_msec()
		)
	return height
