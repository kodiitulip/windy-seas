class_name SceneTransitionButton
extends Button

@export_file("*.tscn") var scene_to_transition_to: String

func _ready() -> void:
	pressed.connect(_on_pressed)
	disabled = scene_to_transition_to.is_empty()


func _on_pressed() -> void:
	SceneTransitionManager.transition_to(scene_to_transition_to)
