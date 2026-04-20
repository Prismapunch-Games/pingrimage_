class_name Level extends Node3D

@export var difficulty: Global.LEVEL_DIFFICULTY = Global.LEVEL_DIFFICULTY.EASY

func _ready():
	Global.current_level_node = self
	Global.on_level_changed.emit(name)
	Global.unlocked_levels.append(name)
	
	var player_manager : PlayerManager = get_tree().root.get_node("World")
	
	if player_manager:
		player_manager.collect_deployed_agents()
	else:
		push_error("(level.gd) Cannot find PlayerManager, therefor, cannot collect PlayerAgents.")

	
