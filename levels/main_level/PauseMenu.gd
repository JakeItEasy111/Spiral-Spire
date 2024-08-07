extends Control

func resume():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	visible = false

func pause():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	visible = true
	
func testEsc():
	if Input.is_action_just_pressed("escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("escape") and get_tree().paused and !$"../DeathScreen".visible == true:
		resume()

func _on_resume_pressed():
	resume()

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://levels/menu/menu.tscn")
	
func _process(_delta):
	testEsc()

func _on_restart_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
