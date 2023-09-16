extends CharacterBody3D

@onready var navigator = $Navigator as NavigationAgent3D

const speed = 1.0

func _physics_process(delta):
	var current_loc = global_transform.origin
	var next_location = navigator.get_next_path_position()
	
	if not is_on_floor(): 
		velocity.y = moving.apply_gravity(velocity.y, is_on_floor(), delta)
	if is_on_floor(): 
		velocity = moving.chase_player(next_location, current_loc, speed)
	move_and_slide()

#func chase_player(navigator):

pass
