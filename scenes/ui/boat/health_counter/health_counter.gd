extends HBoxContainer

@onready var progress: TextureProgressBar = $TextureProgressBar

func _ready() -> void:
	GlobalSignalBus.health_changed.connect(_on_health_changed)


func _on_health_changed(health: float, max_health: float) -> void:
	progress.value = health
	progress.max_value = max_health
