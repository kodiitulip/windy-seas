extends GPUParticles3D

func _ready() -> void:
	GlobalSignalBus.speed_changed.connect(_on_speed_changed)
	
	
func _on_speed_changed(speed: float, max_speed: float) -> void:
	amount_ratio = speed / max_speed
