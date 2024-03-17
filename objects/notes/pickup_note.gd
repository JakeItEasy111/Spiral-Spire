extends Area3D

@onready var interact_sfx = $"../InteractSFX"
@onready var note_UI = $"../NoteLayer"

func use():
	if(!note_UI.visible):
		note_UI.visible = true
		interact_sfx.play()
	
func _process(delta):
	if note_UI.visible:
		if Input.is_action_just_pressed("escape") or Input.is_action_just_pressed("fire"):
			interact_sfx.play()
			note_UI.visible = false 
