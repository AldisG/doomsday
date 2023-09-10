extends Node3D

var nodesReady = false

@export var player: CharacterBody3D
@onready var timer = $Timer

func _ready():
	timer.start()
	pass

func _physics_process(_delta):
	if nodesReady : get_tree().call_group("NAVIGATOR", "update_target_location", player.global_transform.origin)
	pass


func _on_timer_timeout():
	nodesReady = true
	timer.stop()
	timer.queue_free()
	pass # Replace with function body.
