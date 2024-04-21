extends Control

var next_scene = preload("res://levels/main_level/world.tscn")

func _ready():
	get_tree().paused = false

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(next_scene)

func _on_quit_button_pressed():
	get_tree().quit() 
