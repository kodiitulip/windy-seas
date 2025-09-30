class_name OceanWaves
extends Resource

@export var params: Array[Vector3] = []
@export var directions: Array[Vector2] = [Vector2.ZERO]


func _init() -> void:
	params.resize(3)
	params.fill(Vector3.ONE)
	directions.resize(3)
	directions.fill(Vector2.ONE)
