extends GridMap


# Called when the node enters the scene tree for the first time.
func _ready():
	print("=== DEBUG GRIDMAP ===")
	for cell in get_used_cells():
		print("Cell:", cell, " GridFloor (Y):", cell.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
