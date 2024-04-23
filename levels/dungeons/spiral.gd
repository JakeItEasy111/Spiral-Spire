extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_timer_timeout():
	$NavigationRegion3D/GridMap.visible = false
	await get_tree().create_timer(0.2).timeout
	$NavigationRegion3D/GridMap.visible = true
	$Timer.wait_time = randi() % 5
