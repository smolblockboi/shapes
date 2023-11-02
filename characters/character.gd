extends CharacterBody3D
class_name Character

var input_dir : Vector2 = Vector2.ZERO
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity") * 0.5

@export var move_speed : float = 200.0
@export var jump_power : float = gravity * 1.5


func _physics_process(delta):
	get_inputs(delta)
	
	move_and_slide()


func get_inputs(delta):
	velocity.x = (move_speed * input_dir.x) * delta
	velocity.z = (move_speed * input_dir.y) * delta
	
	if is_on_floor():
		velocity.y -= gravity
	else:
		velocity.y -= gravity * 0.125
	
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		do_jump()


func do_jump():
	velocity.y = 0.0
	velocity.y += jump_power


func _on_kill_zone_body_entered(body):
	pass # Replace with function body.
