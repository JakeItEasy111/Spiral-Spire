extends Node

signal change_level

func _on_area_3d_area_entered(area):
	emit_signal("change_level")
