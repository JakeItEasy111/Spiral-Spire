extends Node

@onready var player = get_tree().get_first_node_in_group("player"); 

func _on_timer_timeout():
	$NavigationRegion3D.visible = false
	await get_tree().create_timer(0.2).timeout
	$NavigationRegion3D.visible = true
	$Timer.wait_time = randi() % 5 + 0.1
	
func _on_area_3d_area_entered(_area):
	player.die()

func _on_destructible_body_cue_end():
	$NavigationRegion3D/PropMap/DestructibleBody.visible = false
	$AudioStreamPlayer.stop()
	await get_tree().create_timer(0.3).timeout
	$NavigationRegion3D/PropMap.visible = false 
	await get_tree().create_timer(0.4).timeout
	$NavigationRegion3D/GridMap.visible = false
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://levels/credits/credits.tscn")
