extends StaticBody3D

@onready var break_sound = $AudioStreamPlayer
@onready var anim_player = $AnimationPlayer

func destroy():
	visible = false
	break_sound.play()
	await get_tree().create_timer(3.0).timeout
	break_sound.stop()
	get_tree().change_scene_to_file("res://levels/credits/credits.tscn")
	
