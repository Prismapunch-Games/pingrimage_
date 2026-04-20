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
signal on_level_start

var robots_currently_moving: Array[PlayerAgent] = []
		
signal on_robot_movement(robots_currently_moving: int)

signal on_robot_end_movement(robot: PlayerAgent)

func add_robot_movement(robot: PlayerAgent):
	if(robots_currently_moving.has(robot)):
		return
	print("ROBOT MOVING")
	robots_currently_moving.append(robot)
	on_robot_movement.emit(robots_currently_moving.size())
	
func remove_robot_movement(robot: PlayerAgent):
	if(!(robots_currently_moving.has(robot))):
		return
	robots_currently_moving.erase(robot)
	on_robot_movement.emit(robots_currently_moving.size())
	on_robot_end_movement.emit(robot)
	
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
signal on_all_signals_finished
	
var signals_emitting: int = 0: 
	set(value):
		signals_emitting = value
		on_signals_emitting_changed.emit(signals_emitting)
		if(signals_emitting == 0):
			on_all_signals_finished.emit()
			
signal on_robot_selected

func _ready():
	on_signals_emitting_changed.connect(_on_signals_emitting_changed)
	#await get_tree().create_timer(1.0).timeout
	#if(!current_level_node):
		#load_level(levels[0])
	
func _on_signals_emitting_changed(amount: int):
	if(amount <= 0 && current_charges <= 0 && !level_won):
		print("you lose!")
		on_level_complete.emit(false, 0.0)
	elif(level_won && amount <= 0):
		print("you win!")
		on_level_complete.emit(true, 0.0)
var level_won: bool = false

var proliferation_number: int = 0

var current_level_node: Node3D
signal on_level_changed(level_name: String)

var levels: Array[PackedScene] = [
	preload("res://scenes/levels/tutorial_simulation_i.tscn"),
	preload("res://scenes/levels/tau_ceti_steppes_i.tscn"),
	preload("res://scenes/levels/Hartman/level_x.tscn"),
	preload("res://scenes/levels/Hartman/level_x_2.tscn"),
	]

func load_level(loading_scene: PackedScene):
	proliferation_number = 0
	level_won = false
	current_charges = 3
	
	if(current_level_node):
		current_level_node.queue_free()
		await current_level_node.tree_exited
	var new_level: Node = loading_scene.instantiate()
	get_node("/root/World").call_deferred("add_child", new_level)
	await new_level.ready
	on_level_start.emit()
	
func load_next_level():
	if(current_level_node):
		var packed_scene = load(current_level_node.scene_file_path)
		var current_level_index = levels.find(packed_scene)
		if(current_level_index >= levels.size() - 1):
			print("end of levels reached")
			return
		load_level(levels[current_level_index + 1])
	
#tutorial stuff	
	
var can_select_robots: bool = true

signal on_set_tutorial_text(new_text: String)
signal on_tutorial_text_closed

enum LEVEL_DIFFICULTY {
	EASY,
	MEDIUM,
	HARD
}

var level_difficulties: Dictionary[LEVEL_DIFFICULTY, AudioStream] = {
	LEVEL_DIFFICULTY.EASY: preload("res://sounds/music/LudumDareEasy.mp3"),
	LEVEL_DIFFICULTY.MEDIUM: preload("res://sounds/music/LudumDareMedium.mp3"),
	LEVEL_DIFFICULTY.HARD: preload("res://sounds/music/LudumDareMedium.mp3"),
}

var blue_towers_activated: int = 0
var blue_towers_in_level: int = 0
