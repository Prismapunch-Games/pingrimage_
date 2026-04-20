extends Button

@onready var difficulty_colors: Array[TextureRect] = [$"Difficulty Color R",$"Difficulty Color L"]
@onready var locked: ColorRect = $Locked

func _ready():
	return

func set_color(_color: Color):
	for difficulty_color in difficulty_colors:
		difficulty_color.modulate = _color
		
func set_label(_text: String, difficulty: Global.LEVEL_DIFFICULTY):
	text = _text
	match(difficulty):
		Global.LEVEL_DIFFICULTY.EASY:
			set_color(Color.GREEN)
		Global.LEVEL_DIFFICULTY.MEDIUM:
			set_color(Color.YELLOW)
		Global.LEVEL_DIFFICULTY.HARD:
			set_color(Color.RED)
		_:
			set_color(Color.GREEN)
