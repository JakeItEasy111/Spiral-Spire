extends "res://entity/enemy/enemy_base.gd"
	
func die():
	await get_tree().create_timer(1.0).timeout
	queue_free()
