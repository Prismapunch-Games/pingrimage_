extends Node3D

@onready var select_arrow = $"../Robot/Select Arrow"
@onready var movement_area = $"../Movement Area"

func _ready():
	start_tutorial()
	
func start_tutorial():
	Global.can_select_robots = false
	select_arrow.hide()
	Global.on_set_tutorial_text.emit("You are sub-processor 622 codenamed \"LANCELOT\". Your primary directive is the expansion and cohesion of the network upon Tau Ceti XIII. This tutorial simulation will instruct you on how to expand your network. Signals are emitted from the green tower and must reach the red tower to successfully expand. Signals travel only a certain range. Press \"EMIT SIGNAL\" and observe the properties of the signal wave.")
	await Global.on_all_signals_finished
	Global.on_set_tutorial_text.emit("Emitting the signal consumes a charge from the tower. You have a limited number of charges per area. You will notice that the signal did not propagate to the red tower. Sub-processor 21 has requisitioned mobile relays to assist us. Select the robot by left clicking it.")
	Global.can_select_robots = true
	select_arrow.show()
	await Global.on_robot_selected
	select_arrow.hide()
	movement_area.show()
	Global.on_set_tutorial_text.emit("Command the robot to move by right clicking a destination. Robots propogate signals the same distance as towers. Position the robot between the two towers.")
	await Global.on_robot_end_movement
	movement_area.hide()
	Global.on_set_tutorial_text.emit("Press \"EMIT SIGNAL\" and observe the properties of the signal wave.")
	var result: Array = await Global.on_level_complete
	if(result[0]):
		Global.on_set_tutorial_text.emit("This concludes the first simulation.")
	else:
		Global.on_set_tutorial_text.emit("You have ran out of charges and doomed the network. Press \"Restart\" to attempt again.")
