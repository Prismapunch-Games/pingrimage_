class_name PlayerAgent
extends CharacterBody3D

@export var movement_speed: float = 5.0

@onready var selection_sprite : Sprite3D = $Sprite3D
@onready var selection_tween : Tween
@export var selection_sprite_active: Color
@export var selection_sprite_idle: Color

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_manager : PlayerManager

func _ready() -> void:
	player_manager = get_tree().current_scene.get_node(".")
	add_to_group("player agent robot")
	_clear_agent_selections()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if navigation_agent.is_navigation_finished():
		velocity.x = 0
		velocity.z = 0
	else:
		var next_path_position: Vector3 = navigation_agent.get_next_path_position()
		var direction = global_position.direction_to(next_path_position)
		var calculatedVelocity = direction * movement_speed
		calculatedVelocity.y = velocity.y
		velocity = calculatedVelocity
		
		look_at(global_position + velocity, Vector3.UP, true)
	
	#_set_animation()
		
	move_and_slide()
	
#func _set_animation():
	#if velocity.x or velocity.z:
		#animation_player.play("")
	#else:
		#animation_player.play("")

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if  event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		player_manager._set_currently_selected_player(self)
		_clear_agent_selections()
		toggle_selection_sprite_visual(true)
		pass

func toggle_selection_sprite_visual(toggle : bool):
	if toggle:
		selection_sprite.modulate = selection_sprite_active
		_toggle_selection_tween(toggle)
	else:
		selection_sprite.modulate = selection_sprite_idle
		_toggle_selection_tween(toggle)
		

func _clear_agent_selections():
	for playerAgent in player_manager.deployedAgents:
		if playerAgent is PlayerAgent:
			playerAgent.toggle_selection_sprite_visual(false)
			
func _toggle_selection_tween(toggle : bool):	
	if toggle:
		selection_tween = create_tween().set_loops()
		selection_tween.tween_property(selection_sprite, "scale", Vector3(1.2, 1.2, 1.2), 0.5)
		selection_tween.set_trans(Tween.TRANS_SINE)
		selection_tween.tween_property(selection_sprite, "scale", Vector3(1.0, 1.0, 1.0), 0.5)
	else:
		if selection_tween:
			selection_tween.stop()

func set_target_position(targetPosition):
	if !targetPosition:
		return
		
	navigation_agent.target_position = targetPosition
