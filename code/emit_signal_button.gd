extends Button

func _ready():
	pressed.connect(_on_pressed)
	
func _on_pressed():
	Global.emit_signal.emit()
