extends Node
	
@onready var transitioner = get_tree().current_scene.get_node("SceneTransition")

func _on_timer_timeout():
	$NavigationRegion3D/GridMap.visible = false
	await get_tree().create_timer(0.2).timeout
	$NavigationRegion3D/GridMap.visible = true
	$Timer.wait_time = randi() % 5 + 0.1

func _on_area_3d_area_entered(area):
	$AudioStreamPlayer.stop()
	transitioner.transition_level(self, "res://levels/dungeons/spiral_two.tscn")
