extends CharacterBody3D

@export var playerNode: CharacterBody3D
@onready var look_dir = $head/lookDir
@onready var animation = $Sprite
@onready var head = $head
@onready var debugText = $DEBUG
@onready var timer = $Timer
@onready var walk_checker = $head/WalkChecker # add this as condition to check, can walk foward more

@onready var state_machine = $StateMachine as StateMachine
@onready var wonder_state = $StateMachine/WonderState as WonderState
@onready var chase_state = $StateMachine/ChaseState as ChaseState

#FOR STATE MACHINE
enum { IDLE, ALERT, MOVE }
enum {FACE_L, FACE_R, FACE_B, FACE_F}

var mobStatus = IDLE
var facingDir = FACE_F
var roamDir = 1
var playerVisible: bool = false

func _ready():
	# doesnt switch states
	wonder_state.saw_player.connect(state_machine.change_state.bind(chase_state))
	chase_state.lost_player.connect(state_machine.change_state.bind(wonder_state))
	#setTimeouts()
	mobStatus = IDLE
	pass

func _physics_process(delta):
	#velocity.y = moving.apply_gravity(velocity.y, is_on_floor(), delta)
	#move_and_slide()
	pass

func _process(delta):
	#debugText.text = str(timer.time_left, roamDir)
	if playerNode:
		if playerVisible:
			var p = playerNode.global_position
			look_at(Vector3(p.x, global_position.y, p.z))
			
			#var dir = (playerNode.global_position - global_position).normalized()
			#dir should be determined depending is char going to X asis and Z axis + or -
			"""if (dir.z > -0.5 and dir.z < 0.5): facingDir = 'back'
			if (dir.z > 0.5 and dir.z < 1): facingDir = 'left'
			if (dir.z < -0.5 and dir.z > -1): facingDir = 'right'
			if (dir.z < 0.5 and dir.z > -0.5): facingDir = 'front'
			print(dir.z < 0.5 and dir.z > -0.5, dir.z) debugText.text =  facingDir"""
	else:
		# roam
		pass
	
	# animation mobStatuss
	match mobStatus:
		IDLE: animation.play("s_f")
		ALERT: pass
		MOVE: animation.play("w_f")
	pass
# CUSTOM FUNCS v ---
func checkBodyType(bodies, entrance):
	for group in bodies.get_groups():
		if "PLAYER" == group:
			timer.stop()
			
			if entrance == "entered":
				playerVisible = true
				return
			else:
				#setTimeouts()
				playerVisible = false
				return
	pass

func stopCharacter():
	velocity = Vector3(0, velocity.y, 0)
	mobStatus = IDLE
	pass

func setTimeouts():
	var n = 10
	var randomTimeout = roundf(randi_range(2, n))
	timer.start(randomTimeout)
	roamDir = -1 * roamDir
	pass

# EVENTS V ---
func _on_area_3d_body_entered(body):
	checkBodyType(body, "entered")
	pass

func _on_area_3d_body_exited(body):
	#setTimeouts()
	checkBodyType(body, "exited")
	pass

func _on_timer_timeout():
	#setTimeouts()
	pass

func _on_look_dir_visibility_changed(body):
	pass # Replace with function body.
