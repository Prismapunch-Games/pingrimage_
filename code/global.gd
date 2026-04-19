extends Node

var greek_symbols: Array[String] = ["α","β","γ","δ"]

var max_charges: int = 3 :
	set(value):
		max_charges = value
		on_charges_changed.emit(current_charges, max_charges)
	
var current_charges: int = max_charges : 
	set(value):
		current_charges = value
		on_charges_changed.emit(current_charges, max_charges)

signal on_charges_changed(charges, max_charges)

signal emit_signal

signal on_level_complete(win: bool, time: float)

var robots_currently_moving: Array[PlayerAgent] = []
		
signal on_robot_movement(robots_currently_moving: int)

func add_robot_movement(robot: PlayerAgent):
	if(robot in robots_currently_moving):
		return
	robots_currently_moving.append(robot)
	on_robot_movement.emit(robots_currently_moving.size())
	
func remove_robot_movement(robot: PlayerAgent):
	robots_currently_moving.erase(robot)
	on_robot_movement.emit(robots_currently_moving.size())
	
var direction_arrow_scene: PackedScene = preload("res://scenes/direction_arrow.tscn")

var ping_sounds: Array[AudioStream] = [
	preload("res://sounds/sfx/SignalSend1.mp3"),
	preload("res://sounds/sfx/SignalSend2.mp3"),
	preload("res://sounds/sfx/SignalSend3.mp3"),
	preload("res://sounds/sfx/SignalSend4.mp3"),
	preload("res://sounds/sfx/SignalSend5.mp3"),
	preload("res://sounds/sfx/SignalSend6.mp3"),
	preload("res://sounds/sfx/SignalSendComplete.mp3"),
	]
	
signal on_signals_emitting_changed(signal_amount: int)
	
var signals_emitting: int = 0: 
	set(value):
		signals_emitting = value
		on_signals_emitting_changed.emit(signals_emitting)

func _ready():
	on_signals_emitting_changed.connect(_on_signals_emitting_changed)
	
func _on_signals_emitting_changed(amount: int):
	if(amount <= 0 && current_charges <= 0 && !level_won):
		print("you lose!")
		on_level_complete.emit(false, 0.0)
	elif(level_won):
		print("you win!")
		on_level_complete.emit(true, 0.0)
var level_won: bool = false
