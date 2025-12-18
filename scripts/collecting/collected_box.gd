class_name CollectedBoxArea3D extends Area3D

signal collected()

func _ready() -> void:
	monitorable = false
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D) -> void:
	if area is not CollectorBoxArea3D:
		return
	collected.emit()
