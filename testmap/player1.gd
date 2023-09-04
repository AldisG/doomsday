extends CharacterBody3D

const SPEED = 450
const WALK_SPEED = 250 #unused yet (shift)
const JUMP_VELOCITY = 15

var max_speed = 8
var mouse_sensitivity = 0.002

signal pressed_interact

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func get_input():
	var input_dir = Vector3()
	
	if Input.is_action_pressed("ui_up"):
		input_dir -= global_transform.basis.z
	if Input.is_action_pressed("ui_down"):
		input_dir += global_transform.basis.z
	if Input.is_action_pressed("ui_left"):
		input_dir -= global_transform.basis.x
	if Input.is_action_pressed("ui_right"):
		input_dir += global_transform.basis.x
	input_dir = input_dir.normalized() # disables strafe running
	pass

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		$pivot.rotation.x = clamp($pivot.rotation.x,-1.2,1.2)
		
	if Input.is_action_pressed("quit"): get_tree().quit()
	if Input.is_action_just_pressed("ui_accept"): pressed_interact.emit()
	pass

func _physics_process(delta):
	velocity.y = moving.apply_gravity(velocity.y, is_on_floor(), delta)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y += JUMP_VELOCITY
	
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	velocity = moving.handle_walking(direction, velocity, SPEED, delta)
	move_and_slide()
	pass

func _process(delta):
	pass

func change_gun(gun):
	pass
