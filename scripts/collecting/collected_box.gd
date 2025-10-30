class_name CollectedBoxArea3D extends Area3D

signal collected()

@export var target_node: Node3D

func _ready() -> void:
	monitorable = false
	area_entered.connect(_on_area_entered)
	collected.connect(target_node.queue_free if target_node else queue_free)


func _on_area_entered(area: Area3D) -> void:
	if area is not CollectorBoxArea3D:
		return
	collected.emit()
