extends CharacterBody3D

@onready var debugText = $DEBUG

func _physics_process(delta):
	debugText.text =  str(velocity.y)
	velocity.y = moving.apply_gravity(velocity.y, is_on_floor(), delta)
	
	move_and_slide()
	pass

