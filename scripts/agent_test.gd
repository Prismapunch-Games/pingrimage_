class_name AgentTest
extends CharacterBody3D

@export var movement_speed: float = 4.0
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
#@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	add_to_group("player")

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

func set_target_position(targetPosition):
	navigation_agent.target_position = targetPosition
