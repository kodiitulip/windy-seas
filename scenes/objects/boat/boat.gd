class_name BoatBody3D
extends RigidBody3D

@export var mouse_sensitivity: float = 0.20
@export var max_speed: float = 10.0
@export var flip_foward: bool = false

@export var acceleration_rate: float = 8.0
@export var deacceleration_rate: float = 12.0
@export var brake_power: float = 20.0

var curr_speed: float = 0.0

func _physics_process(delta: float) -> void:
	_handle_move(delta)
	_handle_steer()


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
	apply_central_force(global_transform.basis * dir * curr_speed)
	GlobalSignalBus.emit_speed_changed(curr_speed, max_speed)


func _handle_steer() -> void:
	var rotation_dir: float = -Input.get_axis(&"turn_left", &"turn_right")
	apply_torque(Vector3(0, rotation_dir * curr_speed, 0))
	GlobalSignalBus.emit_direction_changed(rotation_dir)
