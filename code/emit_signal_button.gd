extends Button

func _ready():
	pressed.connect(_on_pressed)
	Global.on_robot_movement.connect(_on_robot_movement)
	Global.on_signals_emitting_changed.connect(_on_robot_movement)
	Global.on_level_start.connect(func():disabled = false)
	
func _on_pressed():
	if(Global.current_charges > 0):
		Global.emit_signal.emit()
		Global.current_charges -= 1
		
func _on_robot_movement(robots_currently_moving: int):
	disabled = Global.robots_currently_moving.size() > 0 || Global.signals_emitting > 0 || Global.level_won
