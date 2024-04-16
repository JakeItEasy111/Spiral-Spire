extends Node3D

@onready var pickup_sfx = $AudioStreamPlayer

func pickup():
	pickup_sfx.play() 
	visible = false
