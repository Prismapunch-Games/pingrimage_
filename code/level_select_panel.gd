extends Panel

@onready var close_button: TextureButton = $"MarginContainer/VBoxContainer/Label/Close Button"
@onready var button_container: Control = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
var level_select_button_scene: PackedScene = preload("res://scenes/main_menu/level_select_button.tscn")

func _ready():
	close_button.pressed.connect(func():hide())
	for child in button_container.get_children():
		button_container.remove_child(child)
	for level in Global.levels:
		var index = Global.levels.find(level)
		var new_button = level_select_button_scene.instantiate()
		var level_scene: Level = level.instantiate()
		var level_name = level_scene.name
		var level_difficulty = level_scene.difficulty
		level_scene.queue_free()
		
		new_button.pressed.connect(func():
			var world_scene: PackedScene = preload("res://scenes/world.tscn")
			var world_node = world_scene.instantiate()
			Global.force_load_level = level
			get_node("/root/MainMenu").queue_free()
			get_tree().root.add_child(world_node)
			
			)
		button_container.add_child(new_button)
		new_button.set_label(level_name, level_difficulty)
		if(level_name in Global.unlocked_levels):
			new_button.locked.hide()
