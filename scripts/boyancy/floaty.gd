@tool
class_name FloatyMarker3D
extends Marker3D

static var wave_a: Vector3 = Vector3(0.4, 0.5, 20.0)
static var wave_a_dir: Vector2 = Vector2(1.0, 0.0)
static var wave_b: Vector3 = Vector3(0.4, 0.4, 16.0)
static var wave_b_dir: Vector2 = Vector2(1.0, 1.0)
static var wave_c: Vector3 = Vector3(0.5, 0.4, 9.0)
static var wave_c_dir: Vector2 = Vector2(1.0, 0.5)

var time: float = 0.0
var water_height: float = 0.0

func _process(delta: float) -> void:
	time += delta


func _p(wave: Vector3, wave_dir: Vector2, p: Vector2, t: float) -> Vector3:
	var amplitude: float = wave.x
	var steepness: float = wave.y
	var wavelength: float = wave.z
	var k: float = 2.0 * PI / wavelength
	var c: float = sqrt(9.8 / k)
	var d: Vector2 = wave_dir.normalized()
	var f: float = k * (d.dot(p) - c * t)
	var a: float = steepness / k
	
	var dx: float = d.x * a * cos(f)
	var dy: float = amplitude * a * sin(f)
	var dz: float = d.y * a * cos(f)
	
	return Vector3(dx, dy, dz)


func _get_wave(x: float, z: float) -> Vector3:
	var v: Vector3 = Vector3(x, 0, z)
	v += _p(wave_a, wave_a_dir, Vector2(x, z), time)
	v += _p(wave_b, wave_b_dir, Vector2(x, z), time)
	v += _p(wave_c, wave_c_dir, Vector2(x, z), time)
	return v


func get_wave(x: float, z: float) -> Vector3:
	var v0: Vector3 = _get_wave(x, z)
	var offset: Vector3 = _get_wave(x - v0.x, z - v0.z)
	var v1: Vector3 = _get_wave(x + offset.x / 4.0, z + offset.y / 4.0)
	return v1


func _get_world_coord_offset(parent: Node3D) -> Vector3:
	return global_transform.origin - parent.position


func _physics_process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	var parent: RigidBody3D = owner as RigidBody3D
	#parent.apply_force(Vector3.DOWN * 9.8, _get_world_coord_offset(parent))
	
	var wave: Vector3 = get_wave(global_transform.origin.x, global_transform.origin.z)
	var wave_height: float = wave.y / 2.0
	water_height = wave_height
	var height: float = global_transform.origin.y
	
	if height >= wave_height:
			return
	var buoyancy: float = clampf((wave_height - height) / 1.0, 0, 1) * 2
	parent.apply_force(Vector3.UP * 9.8 * buoyancy, _get_world_coord_offset(parent))
	parent.apply_central_force(buoyancy * -parent.linear_velocity * 0.99)
	parent.apply_torque(buoyancy * -parent.angular_velocity * 0.5)


func _get_configuration_warnings() -> PackedStringArray:
	var war: Array[String] = []
	if get_parent() is not RigidBody3D:
		war.append("Floaty Markers are meant to be children of RigidBody3D's")
	return war
