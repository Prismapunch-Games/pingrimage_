class_name Transciever extends Node3D

@onready var reciever: Area3D = $Reciever
@onready var emitter: Area3D = $Emitter
@onready var emitter_player: AnimationPlayer = $"Emitter Animation Player"

var last_signal_id: int = -1
