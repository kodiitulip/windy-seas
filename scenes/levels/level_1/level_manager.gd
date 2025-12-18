class_name LevelManager
extends Node

signal player_won()

@export var won_interface: WonIterface
@export var lost_interface: LostInterface

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
@export var wgate_boat: BoatBody3D

@export_group("Alive Winning Condition", "walive_")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var walive_enable: bool = false

var _points_collected: int = 0
var _current_time: float = 0.0
var _boat_passed: bool = false

func _ready() -> void:
	player_won.connect(won_interface.show, CONNECT_ONE_SHOT)
	if wpoints_enable:
		assert(wpoints_counter_ui != null, "Select Points UI")
		wpoints_counter_ui.max_points = wpoints_points_to_collect
		wpoints_counter_ui.points_changed.connect(func(points: int) -> void:
			_points_collected = points)
	if wgate_enable:
		assert(wgate_finish_gate != null, "Select Finish Gate")
		wgate_finish_gate.boat_passed.connect(_on_finish_gate_boat_passed)
	if walive_enable:
		GlobalSignalBus.health_changed.connect(_on_health_changed)


func _process(_delta: float) -> void:
	if _won_all_conditions():
		set_process(false)
		player_won.emit()


func _on_health_changed(health: float, _max_health: float) -> void:
	if health > 0:
		return
	await get_tree().create_timer(1.0).timeout
	lost_interface.show()


func _won_all_conditions() -> bool:
	var won: bool = wpoints_enable or wtime_enable or wgate_boat
	if wpoints_enable:
		won = _points_collected >= wpoints_points_to_collect and won
	if wtime_enable:
		won = _current_time <= wtime_max_time and won
	if wgate_enable:
		won = _boat_passed and won
	if walive_enable:
		won = AutoGameGlobals.boat_curr_health > 0 and won
	return won


func _on_finish_gate_boat_passed(boat: BoatBody3D, gate: PassingGate) -> void:
	assert(wgate_boat != null, "Boat Not Selected")
	if gate != wgate_finish_gate || boat != wgate_boat:
		print("fail")
		return
	_boat_passed = true
