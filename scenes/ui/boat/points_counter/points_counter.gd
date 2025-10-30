extends HBoxContainer

@onready var label: Label = $Label

var points: int = 0


func _ready() -> void:
	GlobalSignalBus.item_collected.connect(_add_points)


func _add_points(points_delta: int) -> void:
	points += points_delta
	label.text = "%s" % points
