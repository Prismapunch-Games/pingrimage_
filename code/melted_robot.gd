extends Node3D

@onready var transciever: Transciever = $Transciever
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	transciever.reciever.area_entered.connect(_on_recieved)
	
func _on_recieved(_body: Node):
	if(_body is Area3D):
		if(_body.get_parent() is Transciever):
			if(_body.get_parent().last_signal_id == transciever.last_signal_id):
				return
			
			animation_player.play("emit")
			transciever.last_signal_id = _body.get_parent().last_signal_id
			Global.proliferation_number += 1
			transciever.play_ping_sound(-1)
			transciever.emitter_player.play("emit")
