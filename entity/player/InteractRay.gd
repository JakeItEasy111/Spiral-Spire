extends Camera3D

func _process(delta : float) -> void:
	if Input.is_action_just_pressed("interact") and $InteractRay.is_colliding():
		var collider = $InteractRay.get_collider()
		if collider.is_in_group("interactable"):
			collider.use()
