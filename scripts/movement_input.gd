class_name MovementInput
extends Node3D

@onready var currentlySelectedPlayer : PlayerAgent = $Robot

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_mouse_click"):
		var mouseIntersectionVector = _get_3d_mouse_position(event.position)
		
		# If intersecting with PlayerAgent, select PlayerAgent and DON'T move. 
		# Else, move currently selected PlayerAgent.
		
		currentlySelectedPlayer.set_target_position(mouseIntersectionVector)
		
		#if true:
			#pass
		#else:
			#var player = currentlySelectedPlayer
			#player.set_target_position(mouseIntersectionVector)
				

		
func _get_3d_mouse_position(mousePosition2D):
	var currentCamera = get_viewport().get_camera_3d()
	var params = PhysicsRayQueryParameters3D.new()
	
	params.from = currentCamera.project_ray_origin(mousePosition2D)
	params.to = currentCamera.project_position(mousePosition2D, 1000)
	
	var worldspace = get_world_3d().direct_space_state
	var result = worldspace.intersect_ray(params)
	
	if result:
		return result.position

func _set_currently_selected_player(selectedPlayer : PlayerAgent):
	currentlySelectedPlayer = selectedPlayer
