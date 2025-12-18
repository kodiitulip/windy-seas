class_name CollectableNode3D
extends Node3D

@export var points: int = 1

@onready var particles: GPUParticles3D = %Confetti
@onready var pling: AudioStreamPlayer3D = $Particles/Pling
@onready var collected_box: CollectedBoxArea3D = $CollectedBoxArea3D
@onready var barrel: MeshInstance3D = $barrel

func _ready() -> void:
	assert(collected_box != null, "No CollectedBoxArea3D selected!")
	collected_box.collected.connect(collect)


func collect() -> void:
	GlobalSignalBus.emit_item_collected(points)
	particles.emitting = true
	pling.play()
	barrel.hide()
	await create_tween().tween_interval(.5).finished
	queue_free()
