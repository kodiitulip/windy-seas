extends Control

## The next scene to load when pressing continue
@export_file("*.tscn") var next_level: String

func _ready() -> void:
	assert(!next_level.is_empty() and ResourceLoader.exists(next_level),
		"Next Level scene must be a valid scene!")


func _restart_level() -> void:
	SceneTransitionManager.reload_last_scene()


func _next_level() -> void:
	SceneTransitionManager.transition_to(next_level)
