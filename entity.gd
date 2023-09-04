extends CharacterBody3D

class_name GravityBase




func _ready():
	print('ready')
	pass

func _physics_process(delta):
	"""if ENTITY:
		if not is_on_floor():
			if direction:
				velocity.x += (direction * SPEED) * delta
				velocity.z += (direction * SPEED) * delta
			else:
				velocity.x -= SPEED * delta # clamp(0, max_speed, max_speed)
				velocity.z -= SPEED * delta # clamp(0, max_speed, max_speed)""" 
