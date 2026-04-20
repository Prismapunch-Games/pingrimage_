extends Panel

@onready var result_label: Label = $"MarginContainer/VBoxContainer/Result Label"
@onready var next_level_button: Button = $"MarginContainer/VBoxContainer/Next Level"
@onready var main_menu_button: Button = $"MarginContainer/VBoxContainer/HBoxContainer/Main Menu"
@onready var restart_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/Restart

func _ready():
	Global.on_level_complete.connect(_on_level_complete)
	Global.on_game_complete.connect(_on_game_complete)
	Global.on_level_start.connect(func():hide())
	next_level_button.pressed.connect(_on_next_level_button_pressed)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)
	restart_button.pressed.connect(_on_restart_button_pressed)
	hide()
	
func _on_level_complete(win: bool, _time: float):
	show()
	next_level_button.visible = win
	if(win):
		result_label.text = "You win!"
	else:
		result_label.text = "You lost..."
		
func _on_game_complete():
	show()
	next_level_button.visible = false
	result_label.text = "You have successfully completed the assimilation of Tau Ceti XII. GUINEVERE will be pleased to know that another planet as joined the mind. Your rule over te galaxy is one planet bigger. Thank you for playing!"
		
func _on_next_level_button_pressed():
	return
	
func _on_main_menu_button_pressed():
	return
	
func _on_restart_button_pressed():
	return
