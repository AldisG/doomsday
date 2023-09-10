class_name ChaseState

extends State

@onready var playerNode: CharacterBody3D

@export var chase_range: Area3D
@export var enemy_self: CharacterBody3D
@export var speed = 30
#@onready var navigator = $"../../NavigationAgent3D" as NavigationAgent3D

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

func _physics_process(_delta):
	"""
	if navigator:
		var current_loc = enemy_self.global_transform.origin
		var next_loc = navigator.get_next_path_position()
		var new_velocity = (next_loc - current_loc).normalized() * 5.0

		enemy_self.velocity = Vector3(new_velocity.x, enemy_self.velocity.y, new_velocity.z)
		enemy_self.velocity.y = 0
	"""
	#enemy_self.move_and_slide()
	pass

func update_target_location(target_location):
	#navigator.set_target_position(target_location)
	pass
	
func _on_chase_range_body_exited(body: Node3D) -> void:
	var _self = body.is_in_group("ENEMY") 
	if _self: return
	if body.name == "PLAYER":
		playerNode = body
		lost_player.emit()
	pass

func _on_chase_range_body_entered(body):
	if body.name == "PLAYER":
		playerNode = body
	pass
