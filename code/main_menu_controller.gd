extends Node

# Buttons
@export var play_button : Button
@export var settings_button : Button
@export var credits_button : Button
@export var exit_button : Button

@export var settings_exit_button : TextureButton
@export var credits_exit_button : TextureButton

@export var level_select_canvas : CanvasItem
@export var settings_canvas : CanvasItem
@export var credits_canvas : CanvasItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.pressed.connect(play)
	settings_button.pressed.connect(settings)
	credits_button.pressed.connect(credits)
	exit_button.pressed.connect(exit)
	settings_exit_button.pressed.connect(close_all)
	credits_exit_button.pressed.connect(close_all)
	
	level_select_canvas.visible = false;
	settings_canvas.visible = false;
	credits_canvas.visible = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play():
	level_select_canvas.visible = true;
	settings_canvas.visible = false;
	credits_canvas.visible = false;
	pass
	
func settings():
	level_select_canvas.visible = false;
	settings_canvas.visible = true;
	credits_canvas.visible = false;
	pass
	
func credits():
	level_select_canvas.visible = false;
	settings_canvas.visible = false;
	credits_canvas.visible = true;
	pass

func exit():
	get_tree().quit()
	pass
	
func close_all():
	level_select_canvas.visible = false;
	settings_canvas.visible = false;
	credits_canvas.visible = false;
	pass
