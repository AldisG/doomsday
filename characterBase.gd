extends CharacterBody3D

var baseGravity = 80

const maxFallSpeed = 50

func apply_gravity(velocitY, onFloor, delta):
	if not onFloor: 
		var updatedGravity = velocitY
		updatedGravity -= baseGravity * delta
		return clampf(updatedGravity, -maxFallSpeed, maxFallSpeed)
		
	if onFloor: return 0
	pass

func handle_walking(direction, vel, speed, delta):
	var new_vel = Vector3(0, vel.y, 0)
	if direction:
		new_vel.x = move_toward(((direction.x * speed) * delta), speed, 0)
		new_vel.z = move_toward(((direction.z * speed) * delta), speed, 0)
	return new_vel
	pass

func chase_player(player: Vector3, me: Vector3, speed):
	var next_velocity: Vector3
	var next_location = (player - me).normalized()
	return Vector3(next_location.x, 0, next_location.z) * speed

func stopCharacter(): return Vector3(move_toward(velocity.x, 0, 2), velocity.y, move_toward(velocity.z, 0, 2))

# Look at direction of player:
func look_at_player(p: Vector3, _self):
	_self.look_at(Vector3(p.x, _self.global_position.y, p.z))
	


