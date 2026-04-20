extends Node3D

@onready var idle_hand : MeshInstance3D = $hand/hand
@onready var pat_hand : MeshInstance3D = $hand/hand_pat
@onready var thumbs_up_hand : MeshInstance3D = $hand/hand_thumbs_up
@onready var point_hand : MeshInstance3D = $hand/hand_point
@onready var thumbs_down_hand : MeshInstance3D = $hand/hand_thumbs_down

@onready var hand_parent : Node3D = $"."

enum HandState{
	idle,
	pat,
	thumbs_up,
	point_hand,
	thumbs_down_hand
}

@onready var hands : Dictionary[HandState, MeshInstance3D] = {HandState.idle: idle_hand, HandState.pat: pat_hand, HandState.thumbs_up: thumbs_up_hand, HandState.point_hand: point_hand, HandState.thumbs_down_hand: thumbs_down_hand}
var current_hand_state : HandState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_hand_state = HandState.idle
	
func _unhandled_input(event: InputEvent) -> void: # This event is invoked on any input, in which we can decide what to do with the 'event' param.
	if Input.is_action_just_pressed("primary_click"):
		#trigger_hand_change(HandState.pat, 5, event.position)
		_handle_user_playfield_click(event.position, HandState.point_hand, 5)
		pass	
	if Input.is_action_just_pressed("secondary_click"):
		pass	
	if Input.is_action_just_pressed("deselect_player_agent"):
		pass	
		
func _handle_user_playfield_click(mousePosition2D : Vector2, desired_hand_state : HandState, time : int):
	# If intersecting with PlayerAgent, select PlayerAgent and DON'T move. 
	# Else, move currently selected PlayerAgent.
	var params = PhysicsRayQueryParameters3D.new()
	
	params.from = get_viewport().get_camera_3d().project_ray_origin(mousePosition2D)
	params.to = get_viewport().get_camera_3d().project_position(mousePosition2D, 1000)
	
	var worldspace = get_world_3d().direct_space_state
	var result = worldspace.intersect_ray(params)	
	
	if !result:
		return
		
	for hand in hands:
		if hand == desired_hand_state:
			hands[hand].position = result.position
			hands[hand].show()
			await get_tree().create_timer(time).timeout
			hands[hand].hide()
		else:
			hands[hand].hide()
	
	#if currentlySelectedPlayer != null:
		#currentlySelectedPlayer.set_target_position(result.position)
		#print("making arrow")
		#var arrow: Node3D = Global.direction_arrow_scene.instantiate()
		#add_child(arrow)
		#arrow.global_position = result.position + Vector3(0,0.01,0)

#func trigger_hand_change(desired_hand_state : HandState, time : int, position : Vector3):
	#for hand in hands:
		#if hand == desired_hand_state:
			#hands[hand].show()
			#await get_tree().create_timer(time).timeout
			#hands[hand].hide()
		#else:
			#hands[hand].hide()
