extends Area3D

@onready var interact_sfx = $"../InteractSFX"
@onready var note_UI = $"../NoteLayer"
@onready var cooldownTimer = $"../InteractCooldown"

func pickup(state):
	if state:
		note_UI.visible = true
	else:
		note_UI.visible = false
		
func use():
	if(!note_UI.visible):
		note_UI.visible = true
		interact_sfx.play()
		cooldownTimer.start()
	
func _process(_delta):
	if note_UI.visible and cooldownTimer.is_stopped():
		if Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("fire"):
			interact_sfx.play()
			note_UI.visible = false 
	
