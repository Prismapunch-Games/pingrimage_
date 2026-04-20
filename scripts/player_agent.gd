class_name PlayerAgent
extends CharacterBody3D

@export var movement_speed: float = 5.0

# Selection Ring Variables
@onready var selection_sprite : Sprite3D = $Sprite3D
@onready var selection_tween : Tween
@export var selection_sprite_active: Color
@export var selection_sprite_idle: Color

# Nodes
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var player_manager : PlayerManager
@onready var transciever: Transciever = $Transciever
@onready var animation_tree : AnimationTree = $AnimationTree

# Intro Sequence
@onready var drop_pod : Node3D = $DropPodMesh
@onready var drop_pod_destination : Node3D = $DropPodDestination
@onready var robot_mesh : Node3D = $RobotMesh

@onready var drop_pod_tween : Tween

# Audio
@onready var audio_player : AudioStreamPlayer3D = $AudioStreamPlayer3D

func _ready() -> void:
	player_manager = get_tree().current_scene.get_node(".")
	add_to_group("player agent robot")
	transciever.reciever.area_entered.connect(_on_recieved)
	_trigger_intro_sequence()

func _physics_process(delta: float) -> void:
	# Ensure NavigationAgent3D settings are configured to ensure .is_navigation_finished() resolves.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if navigation_agent.is_navigation_finished():
		velocity.x = 0
		velocity.z = 0
		animation_tree.set("parameters/walking/blend_position", 0.0)
		_stop_sfx()
		Global.remove_robot_movement(self)
	else:
		var next_path_position: Vector3 = navigation_agent.get_next_path_position()
		var direction = global_position.direction_to(next_path_position)
		var calculatedVelocity = direction * movement_speed
		calculatedVelocity.y = velocity.y
		velocity = calculatedVelocity
		look_at(global_position + velocity, Vector3.UP, true)
		animation_tree.set("parameters/walking/blend_position", min(velocity.length(), 1.0))
		_play_sfx()
		
	move_and_slide()

func _on_recieved(_body: Node):
	if(_body is Area3D):
		if(_body.get_parent() is Transciever):
			if(_body.get_parent().last_signal_id == transciever.last_signal_id):
				return
			
			animation_tree.get("parameters/playback").travel("emit")
			transciever.last_signal_id = _body.get_parent().last_signal_id
			Global.proliferation_number += 1
			transciever.play_ping_sound(-1)
			transciever.emitter_player.play("emit")

func toggle_selection_sprite_visual(toggle : bool):
	if toggle:
		selection_sprite.modulate = selection_sprite_active
		_toggle_selection_tween(toggle)
	else:
		selection_sprite.modulate = selection_sprite_idle
		_toggle_selection_tween(toggle)
		
func _clear_agent_selections():
	for playerAgent : PlayerAgent in player_manager.deployedAgents:
		playerAgent.toggle_selection_sprite_visual(false)
			
func _toggle_selection_tween(toggle : bool):	
	if toggle:
		selection_tween = create_tween().set_loops()
		selection_tween.tween_property(selection_sprite, "scale", Vector3(1.2, 1.2, 1.2), 0.5).set_trans(Tween.TRANS_SINE)
		selection_tween.tween_property(selection_sprite, "scale", Vector3(1.0, 1.0, 1.0), 0.5).set_trans(Tween.TRANS_SINE)
	else:
		if selection_tween:
			selection_tween.kill()
			
func configure_agent_selection_visual():
	for agent : PlayerAgent in player_manager.deployedAgents:
		if (agent != player_manager.currentlySelectedPlayer):
			agent.toggle_selection_sprite_visual(false)
		else:
			agent.toggle_selection_sprite_visual(true)

func set_target_position(targetPosition):
	if(Global.level_won):
		return
	if !targetPosition:
		return
		
	navigation_agent.target_position = targetPosition
	Global.add_robot_movement(self)
	
func _play_sfx():
	if(!audio_player.playing):
		audio_player.play()
	
func _stop_sfx():
	audio_player.stop()
	
func _trigger_intro_sequence():
	robot_mesh.hide()
	selection_sprite.hide()
	drop_pod_tween = create_tween()
	drop_pod_tween.tween_property(drop_pod, "position", robot_mesh.position, 0.5).set_trans(Tween.TRANS_SINE)
	drop_pod_tween.tween_property(drop_pod, "scale", Vector3(1.2, 1.2, 1.2), 0.2).set_trans(Tween.TRANS_BOUNCE)
	drop_pod_tween.tween_property(drop_pod, "scale", Vector3(1.0, 1.0, 1.0), 0.2).set_trans(Tween.TRANS_BOUNCE)
	drop_pod_tween.tween_property(drop_pod, "position", drop_pod_destination.position, 0.5).set_trans(Tween.TRANS_SINE)
	await get_tree().create_timer(0.9).timeout
	robot_mesh.show()
	selection_sprite.show()
