extends Node

func _ready():
	$AudioStreamPlayer.play(90.0)
	
func _on_event_trigger_area_entered(area):
	get_tree().current_scene.get_node("SceneTransition").change_level_no_transition(self, "res://levels/dungeons/spiral.tscn")
