extends Node3D

func _ready():
	Global.current_level_node = self
	Global.on_level_changed.emit(name)
