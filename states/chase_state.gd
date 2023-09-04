class_name ChaseState

extends State

@onready var playerNode: CharacterBody3D

@export var chase_range: Area3D
@export var enemy_self: CharacterBody3D
@export var speed = 80

var playerVisible = false

signal lost_player

func _ready() -> void:
	playerVisible = false
	pass

func _enter_state():
	playerVisible = true
	pass

func _exit_state():
	playerVisible = false
	pass

func _process(delta):
	if playerNode and playerVisible and enemy_self.is_on_floor():
		var distance = enemy_self.global_transform.origin.distance_to(playerNode.global_transform.origin)
		var dir = (playerNode.global_transform.origin - enemy_self.global_transform.origin).normalized()
		
		if distance > 2:
			#use navigation to find player
			enemy_self.velocity = moving.handle_walking(dir, enemy_self.velocity, speed, delta)
			#enemy_self.velocity = Vector3(dir.x * speed, enemy_self.velocity.y, dir.z * speed)
		else: enemy_self.stopCharacter()
			
	else: 
		enemy_self.stopCharacter()
		#enemy_self.velocity = Vector3(enemy_self.roamDir * speed, enemy_self.velocity.y, enemy_self.roamDir * speed)
		pass
	enemy_self.move_and_slide()
	pass

func _on_chase_range_body_exited(body: Node3D) -> void:
	var enemy_self = body.is_in_group("ENEMY") 
	if enemy_self: return
	if body.name == "PLAYER":
		playerNode = body
		lost_player.emit()
		#print("player exited area - chase")
	pass # Replace with function body.


func _on_chase_range_body_entered(body):
	if body.name == "PLAYER":
		playerNode = body
	pass # Replace with function body.
