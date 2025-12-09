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

var _points_collected: int = 0
var _current_time: float = 0.0

@onready var won_interface: Control = %WonInterface

func _ready() -> void:
	won_interface.hide()
	player_won.connect(won_interface.show, CONNECT_ONE_SHOT)


func _process(_delta: float) -> void:
	if wpoints_enable and wpoints_counter_ui:
		_setup_points_conition()
	if _won_all_conditions():
		set_process(false)
		player_won.emit()


func _setup_points_conition() -> void:
	wpoints_counter_ui.max_points = wpoints_points_to_collect
	_points_collected = wpoints_counter_ui.points


func _won_all_conditions() -> bool:
	var won: bool = wpoints_enable or wtime_enable
	if wpoints_enable:
		won = _points_collected >= wpoints_points_to_collect and won
	if wtime_enable:
		won = _current_time <= wtime_max_time and won
	return won
