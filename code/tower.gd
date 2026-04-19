class_name Tower extends Node3D

@onready var transciever: Transciever = $Transciever

func _ready():
	Global.emit_signal.connect(_on_emit_signal)
	
func _on_emit_signal():
	transciever.emitter_player.play("emit")
	transciever.last_signal_id = randi()
	pass
