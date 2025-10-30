class_name SignalBus extends Node

signal direction_changed(direction: float)
signal speed_changed(speed: float, max_speed: float)

signal item_collected(points: int)


func emit_direction_changed(direction: float) -> void:
	direction_changed.emit(direction)


func emit_speed_changed(speed: float, max_speed: float) -> void:
	speed_changed.emit(speed, max_speed)


func emit_item_collected(points: int = 0) -> void:
	item_collected.emit(points)
