class_name SignalBus extends Node

signal direction_changed(direction: float)

signal speed_changed(speed: float)

func emit_direction_changed(direction: float) -> void:
	direction_changed.emit(direction)

func emit_speed_changed(speed: float) -> void:
	speed_changed.emit(speed)
