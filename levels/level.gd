extends Node3D


func _on_kill_zone_body_entered(body):
	if body is Player:
		body.queue_free()

