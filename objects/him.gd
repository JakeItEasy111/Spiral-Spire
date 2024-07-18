extends StaticBody3D

@onready var break_sound = $AudioStreamPlayer

signal cue_end

func destroy():
	visible = false
	break_sound.play()
	emit_signal("cue_end")
