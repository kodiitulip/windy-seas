class_name LevelManager
extends Node

signal player_won()

@export_group("Points Winning Condition", "wpoints_")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var wpoints_enable: bool = false
@export var wpoints_counter_ui: PointsCounterInterface
@export_range(1, 20, 1, "or_greater") var wpoints_points_to_collect: int

@export_group("Time Winning Condition", "wtime_")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var wtime_enable: bool = false
@export var wtime_timer_ui: Control
@export_range(1, 20, 1, "or_greater") var wtime_max_time: float

@export_group("Finish Gate Winning Condition", "wgate_")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var wgate_enable: bool = false
@export var wgate_finish_gate: PassingGate
@export var wgate_boat: PassingGate

var _points_collected: int = 0
var _current_time: float = 0.0
var _boat_passed: bool = false

@onready var won_interface: Control = %WonInterface

func _ready() -> void:
	won_interface.hide()
	player_won.connect(won_interface.show, CONNECT_ONE_SHOT)
	if wpoints_enable:
		assert(wpoints_counter_ui != null, "Select Points UI")
		wpoints_counter_ui.max_points = wpoints_points_to_collect
		wpoints_counter_ui.points_changed.connect(func(points: int) -> void:
			_points_collected = points)
	if wgate_enable:
		assert(wgate_finish_gate != null, "Select Finish Gate")
		wgate_finish_gate.boat_passed.connect(_on_finish_gate_boat_passed)


func _process(_delta: float) -> void:
	if _won_all_conditions():
		set_process(false)
		player_won.emit()


func _won_all_conditions() -> bool:
	var won: bool = wpoints_enable or wtime_enable
	if wpoints_enable:
		won = _points_collected >= wpoints_points_to_collect and won
	if wtime_enable:
		won = _current_time <= wtime_max_time and won
	if wgate_enable:
		won = _boat_passed and won
	return won


func _on_finish_gate_boat_passed(boat: BoatBody3D, gate: PassingGate) -> void:
	assert(wgate_boat != null, "Boat Not Selected")
	if gate != wgate_finish_gate || boat != wgate_boat:
		return
	_boat_passed = true
