extends CharacterBody3D

@export var hp_max : int = 100
@export var hp : int = hp_max: set = set_hp
@export var SPEED: float = 3.0 

@onready var mesh = $MeshInstance3D
@onready var collShape = $CollisionShape3D

signal hp_change 

func _physics_process(_delta):
	move_and_slide() 

func set_hp(new_hp):
	hp = new_hp
	emit_signal("hp_change")
	if hp <= 0:
		die()
	return hp

func take_damage(dmg):
	set_hp(hp - dmg)

func die():
	pass
