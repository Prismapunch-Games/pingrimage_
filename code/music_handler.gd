extends AudioStreamPlayer3D


func _ready():
	Global.on_level_start.connect(_on_level_start)
	
func _on_level_start():
	if(stream == Global.level_difficulties[Global.current_level_node.difficulty]):
		return
	stream = Global.level_difficulties[Global.current_level_node.difficulty]
	play()
