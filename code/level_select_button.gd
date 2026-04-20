extends Button

@onready var difficulty_colors: Array[TextureRect] = [$"Difficulty Color R",$"Difficulty Color L"]
@export var color: Color

func _ready():
	set_color(color)

func set_color(_color: Color):
	for difficulty_color in difficulty_colors:
		difficulty_color.modulate = _color
