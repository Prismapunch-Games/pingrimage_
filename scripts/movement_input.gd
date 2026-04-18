class_name MovementInput
extends Node3D

@onready var currentlySelectedPlayer : PlayerAgent = $Robot
@onready var currentCamera : Camera3D = get_viewport().get_camera_3d()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_mouse_click"):
		_handle_user_playfield_click(event.position)
		
		# If intersecting with PlayerAgent, select PlayerAgent and DON'T move. 
		# Else, move currently selected PlayerAgent.
		
func _handle_user_playfield_click(mousePosition2D):
	var params = PhysicsRayQueryParameters3D.new()
	
	params.from = currentCamera.project_ray_origin(mousePosition2D)
	params.to = currentCamera.project_position(mousePosition2D, 1000)
	
	var worldspace = get_world_3d().direct_space_state
	var result = worldspace.intersect_ray(params)
	
	if result.collider is PlayerAgent:
		currentlySelectedPlayer = result.get("collider")
	else:
		currentlySelectedPlayer.set_target_position(result.position)

func _set_currently_selected_player(selectedPlayer : PlayerAgent):
	currentlySelectedPlayer = selectedPlayer
