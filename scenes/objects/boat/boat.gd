extends RigidBody3D

@export var mouse_sensitivity: float = 0.20
@export var max_speed: float = 10.0

var curr_speed: float = 0.0
var curr_max_speed: float = 0.0
var sails_raised: bool = true
var anchor_down: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"arm_sails"):
		sails_raised = false
	if event.is_action_pressed(&"raise_sails"):
		sails_raised = true
	if event.is_action_pressed(&"toggle_anchor"):
		anchor_down = !anchor_down


func _physics_process(delta: float) -> void:
	curr_max_speed = _get_max_speed()
	curr_speed = (0.0
		if anchor_down
		else ( curr_max_speed
		if is_equal_approx(curr_speed, curr_max_speed)
		else move_toward(curr_speed, curr_max_speed, delta * 2.0) )
	)

	var rotation_dir: float = -Input.get_axis(&"rotate_left", &"rotate_right")
	apply_central_force(global_transform.basis * Vector3.FORWARD * curr_speed)
	apply_torque(Vector3(0, rotation_dir * curr_speed, 0))


func _get_max_speed() -> float:
	return 0.0 if sails_raised else max_speed
