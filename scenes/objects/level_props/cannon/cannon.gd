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
	add_child(ball)
	ball.global_position = marker.global_position
	ball.apply_central_impulse(global_transform.basis * Vector3.BACK * force)


func fire() -> void:
	var t: Tween = create_tween()
	for i: int in amount_of_shots:
		t.tween_callback(_fire_one_shot)
		t.tween_interval(shot_interval)
