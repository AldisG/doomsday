class_name ChaseState

extends State

@export var max_distance = 12
@export var chase_range: Area3D
@export var enemy_self: CharacterBody3D
@export var speed = 2
@export var closest_distance_to_player = 1.5
@export var navigator: NavigationAgent3D

var playerVisible = false

signal lost_player

func _ready() -> void: 
	set_physics_process(false)
	playerVisible = false
	
func _enter_state(): 
	set_physics_process(true)
	playerVisible = true
	
func _exit_state(): 
	set_physics_process(false)
	playerVisible = false
	

func _physics_process(_delta):
	var current_loc = enemy_self.global_transform.origin
	var next_location = navigator.get_next_path_position()
	if enemy_self.is_on_floor(): 
		if navigator.distance_to_target() >= closest_distance_to_player:
			enemy_self.velocity = moving.chase_player(next_location, current_loc, speed)
		else: enemy_self.velocity = moving.stopCharacter()
		pass

func _process(_delta):
	if playerVisible: moving.look_at_player(navigator.target_position, enemy_self)
	pass

func _on_chase_range_body_exited(body: Node3D) -> void:
	var _self = body.is_in_group("ENEMY") 
	if _self: return

	if body.name == "PLAYER":
		playerVisible = false
		lost_player.emit()
	pass
func _on_chase_range_body_entered(body):
	if body.name == "PLAYER": playerVisible = true
	pass
# kinda feels pointless to have multiple body entered


func _on_vission_body_exited(body):
	var _self = body.is_in_group("ENEMY") 
	if _self: return

	if body.name == "PLAYER":
		playerVisible = false
		lost_player.emit()
	pass # Replace with function body.
