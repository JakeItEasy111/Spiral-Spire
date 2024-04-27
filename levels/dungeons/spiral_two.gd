extends Node

@onready var player = get_tree().get_first_node_in_group("player"); 

func _on_timer_timeout():
	$NavigationRegion3D/GridMap.visible = false
	await get_tree().create_timer(0.2).timeout
	$NavigationRegion3D/GridMap.visible = true
	$Timer.wait_time = randi() % 5
	
func _on_area_3d_area_entered(area):
	player.die()
