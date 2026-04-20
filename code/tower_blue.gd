extends Tower

func _ready():
	super()
	Global.emit_signal.connect(_on_emit_signal)
	Global.blue_towers_in_level += 1
	
func _on_recieved(_body: Node):
	if(_body is Area3D):
		if(_body.get_parent() is Transciever):
			if(_body.get_parent().last_signal_id == transciever.last_signal_id):
				return false
			transciever.play_ping_sound(6)
			Global.blue_towers_activated += 1
			flare.show()
			if(Global.blue_towers_activated == Global.blue_towers_in_level):
				Global.level_won = true

func _on_emit_signal():
	flare.hide()
	Global.blue_towers_activated = 0

func _exit_tree():
	Global.blue_towers_in_level -= 1
