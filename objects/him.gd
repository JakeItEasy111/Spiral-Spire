extends StaticBody3D

@onready var break_sound = $AudioStreamPlayer
@onready var anim_player = $AnimationPlayer

func destroy():
	visible = false
	break_sound.play()
	$Timer.start()
	await break_sound.finished
	get_tree().change_scene_to_file("res://levels/credits/credits.tscn")
	


func _on_timer_timeout():
	if(visible == true):
		visible = false
	else:
		visible = true
	$Timer.start() 
