extends Control

@export_file("*.tscn") var next_level: String
@export_file("*.tscn") var level_to_restart: String


func _restart_level() -> void:
	SceneTransitionManager.transition_to(level_to_restart)


func _next_level() -> void:
	SceneTransitionManager.transition_to(next_level)
