extends Label

func _ready():
	Global.on_level_changed.connect(func(level_name: String): text = level_name)
