class_name SceneReloadButton
extends Button

func _ready() -> void:
	pressed.connect(SceneTransitionManager.reload_last_scene)
