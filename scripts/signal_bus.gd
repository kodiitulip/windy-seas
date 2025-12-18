class_name SignalBus extends Node

signal direction_changed(direction: float)
signal rotation_changed(rotation: float)
signal speed_changed(speed: float, max_speed: float)
signal health_changed(health: float, max_health: float)

signal item_collected(points: int)


func emit_direction_changed(direction: float) -> void:
	direction_changed.emit(direction)


func emit_rotation_changed(rotation: float) -> void:
	rotation_changed.emit(rotation)


func emit_speed_changed(speed: float, max_speed: float) -> void:
	speed_changed.emit(speed, max_speed)


func emit_item_collected(points: int = 0) -> void:
	item_collected.emit(points)


func emit_health_changed(health_delta: float) -> void:
	AutoGameGlobals.boat_curr_health -= health_delta
	health_changed.emit(AutoGameGlobals.boat_curr_health,
		AutoGameGlobals.boat_max_health)
