extends Button

func _ready():
	pressed.connect(func():
		Global.load_next_level()
		)
