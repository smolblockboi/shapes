extends CSGMesh3D
class_name Building

@export var hide_these : Array[CSGMesh3D]

var player_inside : bool = false

func _on_interior_area_body_entered(body):
	if body is Player:
		player_inside = true
		for thing in hide_these:
			thing.hide()


func _on_interior_area_body_exited(body):
	if body is Player:
		player_inside = false
		for thing in hide_these:
			thing.show()
