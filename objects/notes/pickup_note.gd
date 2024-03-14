extends Area3D

@onready var pickup_sound = $"../PickupSound"
@onready var note_UI = $"../NoteLayer"

func use():
	note_UI.visible = true
	await get_tree().create_timer(1.0).timeout  
	
func _process(delta):
	if note_UI.visible == true and Input.is_action_just_pressed("escape"):
		note_UI.visible = false 
