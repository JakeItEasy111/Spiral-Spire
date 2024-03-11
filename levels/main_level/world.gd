extends Node3D

@onready var player = $Player

func _physics_process(delta):
	if(player != null):
		get_tree().call_group("enemies", "set_target_position", player.global_transform.origin)


func _on_player_player_hit():
	var flash = $Control/ColorRect
	var tween = get_tree().create_tween()
	flash.visible = true;  
	await tween.tween_property(flash, "modulate:a", 0.5, 0.125).finished
	await tween.tween_property(flash, "modulate:a", 0.0, 0.125).finished
	flash.visible = false; 
