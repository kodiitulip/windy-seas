class_name BoatBody3D
extends RigidBody3D

signal above_water()

@export var mouse_sensitivity: float = 0.20
@export var max_speed: float = 10.0
@export var flip_foward: bool = false

@export var acceleration_rate: float = 8.0
@export var deacceleration_rate: float = 12.0
@export var brake_power: float = 20.0

@export var freeze_when_off_screen: bool = true

var curr_speed: float = 0.0

func _ready() -> void:
	GlobalSignalBus.health_changed.connect(_on_health_changed)
	GlobalSignalBus.on_explode.connect(_on_explode)


func _physics_process(delta: float) -> void:
	_handle_move(delta)
	_handle_steer()
	if global_position.y >= 1.0:
		above_water.emit()


func _handle_move(delta: float) -> void:
	var accel: float = Input.get_axis(&"deaccelerate", &"accelerate")
	if is_zero_approx(accel):
		curr_speed = move_toward(curr_speed, 0.0, delta * deacceleration_rate)
	elif (curr_speed > 0 and accel < 0) or (curr_speed < 0 and accel > 0):
		curr_speed = move_toward(curr_speed, 0.0, delta * brake_power)
	else:
		curr_speed = move_toward(curr_speed, max_speed * accel, delta *
				acceleration_rate)
	if Input.is_action_just_pressed(&"toggle_anchor"):
		get_tree().create_tween().tween_property(self, ^"curr_speed", 0.0, .2)
	var dir: Vector3 = Vector3.BACK if flip_foward else Vector3.FORWARD
	var force_dir: Vector3 = global_transform.basis * dir
	apply_central_force(Vector3(force_dir.x, 0.0, force_dir.z) * curr_speed)
	GlobalSignalBus.emit_speed_changed(curr_speed, max_speed)


func _handle_steer() -> void:
	var rotation_dir: float = -Input.get_axis(&"turn_left", &"turn_right")
	apply_torque(Vector3(0, rotation_dir * curr_speed, 0))
	GlobalSignalBus.emit_direction_changed(rotation_dir)
	#GlobalSignalBus.emit_rotation_changed(rotation.y)


func _get_floaties() -> Array[FloatyMarker3D]:
	var floaties: Array[FloatyMarker3D] = []
	var children: Array = get_children().filter(func(child: Node) -> bool:
		return child is FloatyMarker3D)
	floaties.assign(children)
	return floaties


func _on_health_changed(health: float, _m: float) -> void:
	if health > 0:
		return
	sink()
	pass


func sink() -> void:
	for floaty: FloatyMarker3D in _get_floaties():
		floaty.set_physics_process(false)


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	if freeze_when_off_screen:
		set_freeze_enabled(true)


func _on_explode(position_from: Vector3) -> void:
	var direction: Vector3 = position_from - global_position
	var distance: float = position_from.distance_to(global_position)
	apply_impulse((direction * max_speed).limit_length(3.0),
		global_position + global_position.direction_to(position_from) * distance)
