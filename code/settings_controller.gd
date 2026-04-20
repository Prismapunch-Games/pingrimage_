extends Node

@export var master_slider : HSlider # inx 0 is master
@export var music_slider : HSlider # idx 1 is music
@export var sfx_slider : HSlider # inx 2 is SFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	master_slider.value_changed.connect(on_master_changed)
	music_slider.value_changed.connect(on_music_changed)
	sfx_slider.value_changed.connect(on_sfx_changed)
	
	master_slider.value = AudioServer.get_bus_volume_linear(0)
	music_slider.value = AudioServer.get_bus_volume_linear(1)
	sfx_slider.value = AudioServer.get_bus_volume_linear(2)

func on_master_changed(value : float):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
	
func on_music_changed(value : float):
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	
func on_sfx_changed(value : float):
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
