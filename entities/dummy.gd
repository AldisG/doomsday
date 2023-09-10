extends CharacterBody3D

@onready var navigator = $Navigator as NavigationAgent3D

const speed = 1.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	if navigator:
		var current_loc = global_transform.origin
		var next_loc = navigator.get_next_path_position()
		var new_velocity = (next_loc - current_loc).normalized() * speed

		if not is_on_floor(): velocity.y -= gravity * delta
		if is_on_floor(): velocity = Vector3(new_velocity.x, 0, new_velocity.z)
	
	move_and_slide()

#func update_target_location(target_location):
	#navigator.set_target_position(target_location) 
