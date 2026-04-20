extends Panel

@onready var text_label: RichTextLabel = $"MarginContainer/Text Label"

var tween: Tween

func _ready():
	Global.on_tutorial_text_closed.connect(func():hide())
	Global.on_level_start.connect(func():hide())
	hide()
	Global.on_set_tutorial_text.connect(func(new_text: String):
		show()
		text_label.text = new_text
		
		if(tween && tween.is_running()):
			tween.stop()
		text_label.visible_ratio = 0.0
		tween = get_tree().create_tween()
		tween.tween_property(text_label, "visible_ratio", 1.0, text_label.get_total_character_count() / 64.0)
		)
		
		
