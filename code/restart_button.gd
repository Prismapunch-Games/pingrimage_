extends Button

func _ready():
	pressed.connect(func():
		Global.load_level(load(Global.current_level_node.scene_file_path))
		)
