extends Node3D

func _ready():
	start_tutorial()
	
func start_tutorial():
	await get_tree().create_timer(1.0).timeout
	Global.on_set_tutorial_text.emit("Subprocessor 200 has previously failed his mission and has been disposed of. The mother has retained previous attempts so we may take advantage of them. They are unable to use their servos, but their signal generation still works. Press \"EMIT SIGNAL\" and observe the properties of the signal wave.")
	await Global.on_level_complete
	Global.on_set_tutorial_text.emit("This concludes the second simulation.")
