class_name PauseInterface
extends PanelContainer

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"escape"):
		if get_tree().paused: unpause()
		else: pause()


func pause() -> void:
	get_tree().paused = true
	show()
	audio_stream_player.set_stream_paused(false)


func unpause() -> void:
	get_tree().paused = false
	hide()
	audio_stream_player.set_stream_paused(true)
