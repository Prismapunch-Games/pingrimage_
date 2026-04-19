class_name PlayerManager
extends Node3D

@onready var currentlySelectedPlayer : PlayerAgent
@onready var currentCamera : Camera3D = get_viewport().get_camera_3d()

var deployedAgents : Array

func _ready() -> void:
	deployedAgents = get_tree().get_nodes_in_group("player agent robot")

func _unhandled_input(event: InputEvent) -> void: # This event is invoked on any input, in which we can decide what to do with the 'event' param.
	if Input.is_action_just_pressed("primary_click"):
		_handle_user_agent_selection(event.position)
		
	if Input.is_action_just_pressed("secondary_click"):
		_handle_user_playfield_click(event.position)
	
	if Input.is_action_just_pressed("deselect_player_agent"):
		_clear_currently_selected_player()
		
func _handle_user_playfield_click(mousePosition2D):
	# If intersecting with PlayerAgent, select PlayerAgent and DON'T move. 
	# Else, move currently selected PlayerAgent.
	var params = PhysicsRayQueryParameters3D.new()
	
	params.from = currentCamera.project_ray_origin(mousePosition2D)
	params.to = currentCamera.project_position(mousePosition2D, 1000)
	
	var worldspace = get_world_3d().direct_space_state
	var result = worldspace.intersect_ray(params)	
	
	if !result:
		return
	
	if currentlySelectedPlayer != null:
		currentlySelectedPlayer.set_target_position(result.position)
			
func _handle_user_agent_selection(mousePosition2D):
	# If intersecting with PlayerAgent, select PlayerAgent and DON'T move. 
	# Else, move currently selected PlayerAgent.
	var params = PhysicsRayQueryParameters3D.new()
	
	params.from = currentCamera.project_ray_origin(mousePosition2D)
	params.to = currentCamera.project_position(mousePosition2D, 1000)
	
	var worldspace = get_world_3d().direct_space_state
	var result = worldspace.intersect_ray(params)	
	var resultingCollider = result.collider
	
	if !resultingCollider:
		return
	
	if resultingCollider is PlayerAgent:
		_set_currently_selected_player(resultingCollider)

func _set_currently_selected_player(selectedPlayer : PlayerAgent):
	currentlySelectedPlayer = selectedPlayer
	currentlySelectedPlayer.configure_agent_selection_visual()
	
func _clear_currently_selected_player():
	currentlySelectedPlayer = null
	for agent : PlayerAgent in deployedAgents:
		agent.toggle_selection_sprite_visual(false)
