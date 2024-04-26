extends RigidBody3D

@onready var break_sound = $AudioStreamPlayer
@onready var anim_player = $AnimationPlayer

func destroy():
	
	break_sound.play()
