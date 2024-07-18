extends Node

@onready var transitioner = get_tree().current_scene.get_node("SceneTransition")

func _ready():
	$AudioStreamPlayer.play(90.0)
	
func _on_event_trigger_area_entered(area):
	transitioner.load_level(self, "res://levels/dungeons/spiral.tscn")
