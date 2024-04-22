extends Area3D

@onready var world = get_tree().get_node("../../..")
signal seamless_level_change

func _ready():
	world.connect(seamless_level_change)
	
func _on_area_entered(area):
	emit_signal("seamless_level_change")
