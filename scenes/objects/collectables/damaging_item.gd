class_name DamagingItemNode3D
extends RigidBody3D

@export var points: int = 1

@onready var smoke: GPUParticles3D = $Particles/Smoke
@onready var fire: GPUParticles3D = $Particles/Fire
@onready var debri: GPUParticles3D = $Particles/Debri
@onready var explosion_sound: AudioStreamPlayer3D = $Particles/ExplosionSound
@onready var collected_box: CollectedBoxArea3D = $CollectedBoxArea3D
@onready var cannon_ball: MeshInstance3D = $"cannon-ball"

func _ready() -> void:
	assert(collected_box != null, "No CollectedBoxArea3D selected!")
	collected_box.collected.connect(explode)


func explode(damage: bool = true) -> void:
	if damage:
		GlobalSignalBus.emit_health_changed(points)
		GlobalSignalBus.emit_on_explode(global_position)
	smoke.emitting = true
	fire.emitting = true
	debri.emitting = true
	explosion_sound.pitch_scale = randf_range(0.8, 1.2)
	explosion_sound.play()
	cannon_ball.hide()
	await get_tree().create_timer(2.0).timeout
	queue_free()


func _physics_process(_delta: float) -> void:
	if global_position.y < -0.8:
		explode(false)
		set_physics_process(false)
