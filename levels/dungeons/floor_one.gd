extends Node

@onready var transitioner = get_tree().current_scene.get_node("SceneTransition")

func _on_area_3d_area_entered(_area):
	transitioner.transition_level(self, "res://levels/dungeons/floor_two.tscn")
