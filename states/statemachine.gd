class_name StateMachine
extends Node

@export var state: State

func _ready():
	change_state(state)
	pass

func change_state(newState: State):
	if state != newState:
		state._exit_state()
		newState._enter_state()
	state = newState
	print(state)
	pass
