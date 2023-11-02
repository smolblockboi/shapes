extends Character
class_name Player


func _physics_process(delta):
	input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	super.get_inputs(delta) # calls get_inputs from character.gd
	
	super.do_animations(delta) # calls do_animations from character.gd
	
	move_and_slide()
