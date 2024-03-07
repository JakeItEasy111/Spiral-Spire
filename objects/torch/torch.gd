extends Node3D

@onready var anim = $AnimatedSprite3D 
@onready var audio = $BurningSFX 

func _ready():
	anim.play("default")
	audio.play()
