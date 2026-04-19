class_name Tower extends Node3D

@onready var transciever: Transciever = $Transciever
@onready var flare: Sprite3D = $"Top Flare"

@export var recieve_only: bool = false

func _ready():
	if(!recieve_only):
		Global.emit_signal.connect(_on_emit_signal)
	else:
		flare.hide()
		transciever.reciever.area_entered.connect(_on_recieved)
	
func _on_emit_signal():
	transciever.emitter_player.play("emit")
	transciever.play_ping_sound(0)
	transciever.last_signal_id = randi()

func _on_recieved(_body: Node):
	if(_body is Area3D):
		if(_body.get_parent() is Transciever):
			if(_body.get_parent().last_signal_id == transciever.last_signal_id):
				return
			transciever.play_ping_sound(6)
			Global.level_won = true
			flare.show()
