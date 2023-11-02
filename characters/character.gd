extends CharacterBody3D
class_name Character


@onready var body = $Body
@onready var anim_player = $AnimationPlayer


var input_dir : Vector2 = Vector2.ZERO
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity") * 0.5

@export var move_speed : float = 200.0
@export var jump_power : float = gravity * 1.5

var is_facing_right : bool = true

var camera_ref : Camera3D


func _physics_process(delta):
	if camera_ref:
		body.rotation_degrees.x = camera_ref.get_parent().rotation_degrees.x
	
	get_inputs(delta)
	
	do_animations(delta)
	
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


func do_animations(delta):
	if is_on_floor():
		if input_dir != Vector2.ZERO:
			anim_player.play("run")
		else:
			anim_player.play("idle")
	else:
		anim_player.play("jump")
	
	if input_dir.x > 0:
		is_facing_right = true
		body.rotation_degrees.y = lerp(body.rotation_degrees.y, 0.0, 0.25)
	elif input_dir.x < 0:
		is_facing_right = false
		body.rotation_degrees.y = lerp(body.rotation_degrees.y, 180.0, 0.25)
	
	if is_facing_right:
		body.rotation_degrees.y = move_toward(body.rotation_degrees.y, 0.0, 10.0)
	else:
		body.rotation_degrees.y = move_toward(body.rotation_degrees.y, 180.0, 10.0)


func do_jump():
	velocity.y = 0.0
	velocity.y += jump_power
