class_name SceneTransition
extends CanvasLayer

enum TransitionState {
	NONE,
	IN,
	OUT,
}

var _last_scene: String
var scene_uuid_to_transition: String
var transitioning: bool = false
var transition_state: TransitionState = TransitionState.NONE

@onready var progress_bar: ProgressBar = %ProgressBar

func _process(_delta: float) -> void:
	if not transitioning or not scene_uuid_to_transition:
		return
	
	var progress: Array = []
	var load_status: ResourceLoader.ThreadLoadStatus = ResourceLoader\
		.load_threaded_get_status(scene_uuid_to_transition, progress)
	progress_bar.value = progress[0]
	
	if load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene: Resource = ResourceLoader.load_threaded_get(scene_uuid_to_transition)
		_finish_transition(new_scene)


func _finish_transition(loaded_scene: Resource) -> void:
	if not loaded_scene:
		return printerr("Scene has not properly loaded!")
	if loaded_scene is PackedScene:
		get_tree().change_scene_to_packed(loaded_scene as PackedScene)
	transitioning = false
	transition_state = TransitionState.OUT
	scene_uuid_to_transition = ""


func _request_load() -> void:
	if transition_state == TransitionState.OUT:
		return
	if get_tree().current_scene:
		get_tree().unload_current_scene()
	ResourceLoader.load_threaded_request(scene_uuid_to_transition)
	transitioning = true


func transition_to(scene_uuid: String) -> void:
	scene_uuid_to_transition = scene_uuid
	_last_scene = scene_uuid
	transition_state = TransitionState.IN


func reload_last_scene() -> void:
	if _last_scene.is_empty():
		printerr("Could not load last scene"); return
	transition_to(_last_scene)
