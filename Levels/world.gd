extends Node3D

@onready var player = $Player

func _physics_process(delta):
	if !queue_free:
		get_tree().call_group("enemies", "set_target_position", player.global_transform.origin)
	
