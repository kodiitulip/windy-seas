class_name GameGlobals
extends Node

@export_group("Boat Data", "boat_")
@export var boat_max_health: float = 5.0
@export var boat_curr_health: float = 5.0

@export_group("Current Level Data", "level_")
@export var level_curr_points: int = 0

func reset_variables() -> void:
	level_curr_points = 0
	boat_curr_health = boat_max_health
