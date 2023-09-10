extends Node3D

@export var player: CharacterBody3D
var nodesReady = false
@onready var timer = $Timer

func _ready():
	timer.start()
	pass

func _physics_process(_delta):
	if nodesReady : get_tree().call_group("NAVIGATOR", "update_target_location", player.global_transform.origin)
	pass

func _process(delta):
	var frames = ''
	#print(frames)

func _on_timer_timeout():
	nodesReady = true
	timer.stop()
	timer.queue_free()
	pass # Replace with function body.
