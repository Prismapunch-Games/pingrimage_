extends AudioStreamPlayer3D


func _ready():
	Global.on_level_start.connect(_on_level_start)
	Global.on_game_complete.connect(_on_game_complete)
	
func _on_level_start():
	if(stream == Global.level_difficulties[Global.current_level_node.difficulty]):
		return
	stream = Global.level_difficulties[Global.current_level_node.difficulty]
	play()

func _on_game_complete():
	stream = load("res://sounds/music/LudumDareBeatGame.mp3")
	play()
