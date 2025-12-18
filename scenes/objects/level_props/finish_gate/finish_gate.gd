class_name PassingGate
extends Area3D

signal boat_passed(boat: BoatBody3D, gate: PassingGate)

func _ready() -> void:
	body_entered.connect(func(body: PhysicsBody3D) -> void:
		if body is BoatBody3D:
			_on_boat_entered(body as BoatBody3D)
	)


func _on_boat_entered(boat: BoatBody3D) -> void:
	boat_passed.emit(boat, self)
