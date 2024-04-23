extends Node

func _on_area_3d_area_entered(area):
	get_tree().current_scene.get_node("SceneTransition").change_level_scene(self, "res://levels/dungeons/floor_two.tscn")
