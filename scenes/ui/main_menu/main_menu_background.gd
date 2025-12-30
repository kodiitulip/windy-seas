extends Node3D

@onready var follow_camera: PhantomCamera3D = $FollowCamera

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	follow_camera.set_priority(10)
