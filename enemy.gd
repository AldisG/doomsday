extends CharacterBody3D

enum { IDLE, ALERT, MOVE }
#@onready var head = $head
@onready var debugText = $DEBUG
#@onready var timer = $Timer
#@onready var walk_checker = $head/WalkChecker # add this as condition to check, can walk foward more
var playerVisible: bool = false
var mobStatus = IDLE

#FOR STATE MACHINE
@onready var animation = $Sprite
@onready var state_machine = $StateMachine as StateMachine
@onready var wonder_state = $StateMachine/WonderState as WonderState
@onready var chase_state = $StateMachine/ChaseState as ChaseState
@onready var navigator = $Navigator as NavigationAgent3D

@export var max_distance = 6

func _ready():
	wonder_state.saw_player.connect(state_machine.change_state.bind(chase_state))
	chase_state.lost_player.connect(state_machine.change_state.bind(wonder_state))
	mobStatus = IDLE
	pass

func _physics_process(delta):
	debugText.text = str(velocity)
	velocity.y = moving.apply_gravity(velocity.y, is_on_floor(), delta)

	if velocity.normalized(): mobStatus = MOVE
	else: mobStatus = IDLE

	move_and_slide()
	pass

func _process(_delta):
	match mobStatus: 
		IDLE: animation.play("s_f")
		ALERT: pass
		MOVE: animation.play("w_f")
	pass

"""
func setTimeouts():
	#var n = 10
	#var randomTimeout = roundf(randi_range(2, n))
	pass
"""
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
# EVENTS V ---

func _on_timer_timeout():
	navigator.set_velocity(Vector3(3,0,3)) 
	pass



