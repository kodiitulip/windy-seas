class_name PauseInterface
extends PanelContainer

func _ready() -> void:
	hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"escape"):
		if get_tree().paused: unpause()
		else: pause()


func pause() -> void:
	get_tree().paused = true
	show()


func unpause() -> void:
	get_tree().paused = false
	hide()
