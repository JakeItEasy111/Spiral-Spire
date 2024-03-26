extends Control

@onready var health_label = $"../UI/Health"
@onready var death_sound = $AudioStreamPlayer2D

func _process(delta):
	if visible and Input.is_action_just_pressed("space"):
		visible = false 
		health_label.visible = true 
		get_tree().paused = false 
		get_tree().reload_current_scene()

func _on_player_player_dead():
	visible = true
	health_label.visible = false 
	get_tree().paused = true 
	death_sound.play()
