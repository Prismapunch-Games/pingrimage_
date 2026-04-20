extends Panel

@onready var close_button: TextureButton = $"MarginContainer/VBoxContainer/Label/Close Button"
@onready var button_container: Control = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
var level_select_button_scene: PackedScene = preload("res://scenes/main_menu/level_select_button.tscn")

func _ready():
	close_button.pressed.connect(func():hide())
	#for child in button_container.get_children():
		#button_container.remove_child(child)
