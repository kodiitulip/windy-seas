extends RigidBody3D

enum SailState {
	FULL,
	HALF,
	CLOSE,
}

@export var mouse_sensitivity: float = 0.20
@export var max_speed: float = 20.0
@export var min_speed: float = 10.0

var curr_speed: float = 0.0
var curr_max_speed: float = 0.0
var curr_sails_state: SailState = SailState.CLOSE

@onready var hcam: Node3D = %HCamMovement
@onready var vcam: Node3D = %VCamMovement
@onready var com: Marker3D = %CenterOfMass


func _input(event: InputEvent) -> void:
	var cam_controlling: bool = Input.is_action_pressed(&"cam_control")
	if cam_controlling and event is InputEventMouseMotion:
		_handle_camera_movement(event as InputEventMouseMotion, 
				mouse_sensitivity)
	if event.is_action_pressed(&"move_foward"):
		_cycle_sails_state_foward()
	if event.is_action_pressed(&"move_backward"):
		_cycle_sails_state_backward()


# TODO: remove camera controls from the boat script
func _process(_delta: float) -> void:
	hcam.global_position = com.global_position


func _physics_process(delta: float) -> void:
	curr_max_speed = _get_max_speed()
	if not is_equal_approx(curr_speed, curr_max_speed):
		curr_speed = move_toward(curr_speed, curr_max_speed, delta)
	else:
		curr_speed = curr_max_speed

	var rotation_dir: float = -Input.get_axis(&"rotate_left", &"rotate_right")
	apply_central_force(global_transform.basis * Vector3.FORWARD * curr_speed)
	apply_torque(Vector3(0, rotation_dir * minf(curr_speed, 1), 0))


# TODO: remove camera controls from the boat script
func _handle_camera_movement(event: InputEventMouseMotion, sensitivity: float
		) -> void:
	var moviment: Vector2 = event.relative
	vcam.rotation_degrees.x = clampf(
		vcam.rotation_degrees.x - moviment.y * sensitivity,
		-85, -10)
	hcam.rotation_degrees.y -= moviment.x * sensitivity


func _get_max_speed() -> float:
	match curr_sails_state:
		SailState.CLOSE:
			return 0.0
		SailState.HALF:
			return min_speed
		SailState.FULL:
			return max_speed
		_:
			return 0.0


func _cycle_sails_state_foward() -> void:
	match curr_sails_state:
		SailState.CLOSE:
			curr_sails_state = SailState.HALF
		SailState.HALF:
			curr_sails_state = SailState.FULL


func _cycle_sails_state_backward() -> void:
	match curr_sails_state:
		SailState.FULL:
			curr_sails_state = SailState.HALF
		SailState.HALF:
			curr_sails_state = SailState.CLOSE
