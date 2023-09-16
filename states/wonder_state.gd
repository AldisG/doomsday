class_name WonderState
extends State

signal saw_player

@export var chase_range: Area3D
@export var enemy_self: CharacterBody3D
@export var navigator: NavigationAgent3D
@export var timer: Timer

var lastPlace: Vector3
var speed = 2

func _ready(): set_physics_process(false)

func _enter_state():
	set_physics_process(true)
	lastPlace = navigator.get_final_position()
	pass
	
func _exit_state(): set_physics_process(false)

func _physics_process(_delta):
	# Finihsh walking to last location player was in range
	var current_loc = enemy_self.global_transform.origin
	var distance_left = lastPlace.distance_to(current_loc)
	
	if distance_left >= 2: enemy_self.velocity = moving.chase_player(lastPlace, current_loc, speed)
	else: enemy_self.velocity = moving.stopCharacter()

	# should roam
	#timer.one_shot = true
	#timer.start(4)
	pass

#func _process(delta):
	#moving.self_look_at(navigator.target_position, enemy_self)
	#pass

func _on_vission_body_entered(body):
	var _self = body.is_in_group("ENEMY") 
	if _self: return

	if body.name == "PLAYER": saw_player.emit()
	pass 
	pass # Replace with function body.
