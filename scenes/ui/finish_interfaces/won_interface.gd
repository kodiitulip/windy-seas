class_name WonIterface
extends PanelContainer

## The next scene to load when pressing continue
@export_file("*.tscn") var next_level: String

@onready var continue_button: SceneTransitionButton = %Continue

#func _ready() -> void:
	#hide()
	#assert(!next_level.is_empty() and ResourceLoader.exists(next_level),
		#"Next Level scene must be a valid scene!")
	#continue_button.scene_to_transition_to = next_level


func _restart_level() -> void:
	SceneTransitionManager.reload_last_scene()


func _next_level() -> void:
	SceneTransitionManager.transition_to(next_level)
