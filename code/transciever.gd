class_name Transciever extends Node3D

@onready var reciever: Area3D = $Reciever
@onready var emitter: Area3D = $Emitter
@onready var emitter_player: AnimationPlayer = $"Emitter Animation Player"
@onready var ping_sound: AudioStreamPlayer3D = $Ping
var last_signal_id: int = -1
var proliferation_number: int = 0

func play_ping_sound(index: int):
	if(index == -1):
		ping_sound.stream = Global.ping_sounds[proliferation_number]
	else:
		ping_sound.stream = Global.ping_sounds[index]
	ping_sound.play()
	
func start_signal_emission():
	Global.signals_emitting += 1
	
func end_signal_emission():
	Global.signals_emitting -= 1
