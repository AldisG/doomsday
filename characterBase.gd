extends CharacterBody3D

var baseGravity = 80

const maxFallSpeed = 50

func apply_gravity(velocitY, onFloor, delta):
	if not onFloor: 
		var updatedGravity = velocitY
		updatedGravity -= baseGravity * delta
		var finalGravity = clampf(updatedGravity, -maxFallSpeed, maxFallSpeed)
		
		return finalGravity
	if onFloor: 
		return 0
	pass

func handle_walking(direction, vel, speed, delta):
	var new_vel = Vector3(0,0,0)
	if direction:
		#new_vel = Vector3(direction.x * speed, vel.y, direction.z * speed)
		new_vel.x = move_toward(((direction.x * speed) * delta), speed, 0)
		new_vel.z = move_toward(((direction.z * speed) * delta), speed, 0)
		new_vel.y = vel.y
	else:
		new_vel = Vector3(move_toward(velocity.x, 0, speed), vel.y, move_toward(velocity.z, 0, speed))
	return new_vel
	pass

#func update_target_location(target_location,navigator):
	#navigator.set_target_position(target_location) 
