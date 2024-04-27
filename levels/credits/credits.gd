extends Node

func _ready():
	$AnimationPlayer.play("credits")
	await $AnimationPlayer.animation_finished
	get_tree().quit()
