class_name CollectableNode3D
extends Node3D

@export var points: int = 1
@export var collected_box: CollectedBoxArea3D

func _ready() -> void:
	assert(collected_box != null, "No CollectedBoxArea3D selected!")
	collected_box.collected.connect(GlobalSignalBus.emit_item_collected.bind(points))
