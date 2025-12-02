class_name PointsCounterInterface
extends HBoxContainer

@onready var label: Label = $Label

@export var points: int = 0
@export var max_points: int = -1


func _ready() -> void:
	GlobalSignalBus.item_collected.connect(_add_points)
	_add_points(0)


func _add_points(points_delta: int) -> void:
	points += points_delta
	label.text = "%s" % points if max_points <= 0 else "%s / %s" % [points, max_points]
