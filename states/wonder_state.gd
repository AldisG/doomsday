class_name WonderState
extends State

signal saw_player

@export var chase_range: Area3D
@export var enemy_self: CharacterBody3D

func _enter_state():
	set_physics_process(true)
	pass
	
func _exit_state():
	set_physics_process(false)
	pass

func _physics_process(delta):
	enemy_self.velocity.y = moving.apply_gravity(enemy_self.velocity.y, enemy_self.is_on_floor(), delta)
	pass

func _on_chase_range_body_entered(body: Node3D) -> void:
	var _self = body.is_in_group("ENEMY") 
	if _self: return

	if body.name == "PLAYER":
		#print("player entered area - wonder")
		saw_player.emit()
	pass 
