extends Area3D

@export var key : Node3D 

@onready var player : CharacterBody3D = $"../Player"

var locked 

signal open

func _ready():
	if(key != null):
		locked = true
	else:
		locked = false 
	
func use():
	if(!locked):
		emit_signal("open")
	elif(player.hasKey(key)):
		locked = false
		#play unlocking sfx 
