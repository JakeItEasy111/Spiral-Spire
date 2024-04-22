extends Area3D

@onready var world = get_parent().get_parent()
signal level_switch
	
func _on_area_entered(area):
	emit_signal("level_switch")
