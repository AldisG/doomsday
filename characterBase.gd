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
		var x = move_toward(((direction.x * speed) * delta), speed, 0)
		var z = move_toward(((direction.z * speed) * delta), speed, 0)
		new_vel = Vector3(x, vel.y, z)
	else:
		new_vel = Vector3(move_toward(velocity.x, 0, speed), vel.y, move_toward(velocity.z, 0, speed))
	return new_vel
	pass

func chase_player(player: Vector3, me: Vector3, speed):
	var next_velocity: Vector3
	var next_location = (player - me).normalized()
	var vel = Vector3(next_location.x, 0, next_location.z) * speed
	return vel

func stopCharacter():
	return Vector3(0, velocity.y, 0)
	pass
