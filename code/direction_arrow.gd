extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.animation_finished.connect(func(_anim_name): queue_free())
