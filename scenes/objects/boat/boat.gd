extends RigidBody3D

@export var mouse_sensitivity: float = 0.20
@export var max_speed: float = 10.0

var curr_speed: float = 0.0

func _physics_process(delta: float) -> void:
	_handle_move(delta)


func _handle_move(delta: float) -> void:
	if Input.is_action_pressed(&"accelerate"):
		curr_speed = move_toward(curr_speed, max_speed, delta * 2.5)
	if Input.is_action_pressed(&"deaccelerate"):
		curr_speed = move_toward(curr_speed, 0.0, delta * 2.5)
	if Input.is_action_just_pressed(&"toggle_anchor"):
		curr_speed = 0.0
	apply_central_force(global_transform.basis * Vector3.FORWARD * curr_speed)
	var rotation_dir: float = -Input.get_axis(&"turn_left", &"turn_right")
	apply_torque(Vector3(0, rotation_dir * curr_speed, 0))
