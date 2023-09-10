extends CharacterBody3D

@export var playerNode: CharacterBody3D
@onready var animation = $Sprite
@onready var head = $head
@onready var debugText = $DEBUG
@onready var timer = $Timer
#@onready var walk_checker = $head/WalkChecker # add this as condition to check, can walk foward more

#FOR STATE MACHINE
@onready var state_machine = $StateMachine as StateMachine
@onready var wonder_state = $StateMachine/WonderState as WonderState
@onready var chase_state = $StateMachine/ChaseState as ChaseState
@onready var navigator = $Navigator as NavigationAgent3D

enum { IDLE, ALERT, MOVE }

var mobStatus = IDLE
var roamDir = 1
var playerVisible: bool = false

func _ready():
	#wonder_state.saw_player.connect(state_machine.change_state.bind(chase_state))
	#chase_state.lost_player.connect(state_machine.change_state.bind(wonder_state))
	mobStatus = IDLE
	pass

func _physics_process(delta):
	#velocity.y = moving.apply_gravity(velocity.y, is_on_floor(), delta)
	
	if navigator:
		var current_loc = global_transform.origin
		var next_loc = navigator.get_next_path_position()
		print(next_loc)
		var new_velocity = (next_loc - current_loc).normalized() * 21

		#if not is_on_floor(): velocity.y -= gravity * delta
		if is_on_floor(): velocity = Vector3(new_velocity.x, 0, new_velocity.z)
	
		move_and_slide()
	"""
	if navigator:
		var current_loc = global_transform.origin
		var next_loc = navigator.get_next_path_position()
		var new_velocity = (next_loc - current_loc).normalized() * 1

		if is_on_floor():
			velocity = Vector3(new_velocity.x, velocity.y, new_velocity.z)
			velocity.y = 0
	"""
	
	move_and_slide()

func _process(_delta):
	#debugText.text = str(timer.time_left, roamDir)
	#if playerNode:
		#if playerVisible:
			#var p = playerNode.global_position
			#look_at(Vector3(p.x, global_position.y, p.z))
	#else:
		# roam
	match mobStatus:
		IDLE: animation.play("s_f")
		ALERT: pass
		MOVE: animation.play("w_f")
	pass

# CUSTOM FUNCS v ---
func checkBodyType(bodies, entrance):
	for group in bodies.get_groups():
		if "PLAYER" == group:
			#timer.stop()
			if entrance == "entered":
				playerVisible = true
				return
			else:
				playerVisible = false
				return
	pass

func stopCharacter():
	velocity = Vector3(0, velocity.y, 0)
	mobStatus = IDLE
	pass

func setTimeouts():
	#var n = 10
	#var randomTimeout = roundf(randi_range(2, n))
	pass

# EVENTS V ---
func _on_area_3d_body_entered(body):
	checkBodyType(body, "entered")
	pass

func _on_area_3d_body_exited(body):
	checkBodyType(body, "exited")
	pass

func _on_timer_timeout():
	pass
