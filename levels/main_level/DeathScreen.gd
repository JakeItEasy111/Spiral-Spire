extends Control

@onready var game_hud = $"../UI"
@onready var death_sound = $AudioStreamPlayer2D

func _process(_delta):
	if visible and Input.is_action_just_pressed("space"):
		visible = false 
		game_hud.visible = true 
		get_tree().paused = false 
		get_tree().current_scene.get_node("SceneTransition").restart_level() 

func _on_player_player_dead():
	visible = true
	game_hud.visible = false 
	get_tree().paused = true 
	death_sound.play()
