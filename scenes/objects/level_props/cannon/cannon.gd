class_name Cannon
extends Node3D

const DAMAGING_BALL: PackedScene = preload("uid://giyscbdkyi1q")

@export var amount_of_shots: int = 3
@export var shot_interval: float = 0.2
@export var force: float = 50.0
@export var timer_delay: float = 3.0

@onready var timer: Timer = $Timer
@onready var marker: Marker3D = $Marker3D

func _ready() -> void:
	timer.wait_time = timer_delay
	timer.timeout.connect(fire)


func _fire_one_shot() -> void:
	var ball: RigidBody3D = DAMAGING_BALL.instantiate()
	ball.set_as_top_level(true)
	add_child(ball)
	ball.global_position = marker.global_position
	var dir: Vector3 = Vector3.BACK
	dir = dir.rotated(Vector3.UP, randf_range(deg_to_rad(15), deg_to_rad(-15)))
	dir = dir.rotated(Vector3.LEFT, randf_range(deg_to_rad(5), deg_to_rad(-5)))
	ball.apply_central_impulse(global_transform.basis * dir * force)


func fire() -> void:
	var t: Tween = create_tween()
	for i: int in amount_of_shots:
		t.tween_callback(_fire_one_shot)
		t.tween_interval(shot_interval)
