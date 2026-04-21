extends Node3D

func _ready():
	start_tutorial()
	
func start_tutorial():
	await get_tree().create_timer(1.0).timeout
	Global.on_set_tutorial_text.emit("Blue towers function differently. All blue towers must be activated in one signal pulse or their connection will fail.")
	await Global.on_level_complete
	var result: Array = await Global.on_level_complete
	if(result[0]):
		Global.on_set_tutorial_text.emit("This concludes the third simulation.")
	else:
		Global.on_set_tutorial_text.emit("You have ran out of charges and doomed the network. Press \"Restart\" to attempt again.")
