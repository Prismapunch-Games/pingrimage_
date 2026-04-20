extends Button


func _ready():
	pressed.connect(func():
		var packed_scene = load(Global.current_level_node.scene_file_path)
		var current_level_index = Global.levels.find(packed_scene)
		if(current_level_index < Global.levels.size() - 1):
			var next_level_node = Global.levels[current_level_index + 1]
			var next_level_name = next_level_node.get_state().get_node_name(0)
			Global.unlocked_levels.append(next_level_name)
		var main_menu_scene: PackedScene = load("res://scenes/main_menu.tscn")
		var main_menu_node: Node3D = main_menu_scene.instantiate()
		get_node("/root").add_child(main_menu_node)
		get_node("/root/World").queue_free()
		)
 
