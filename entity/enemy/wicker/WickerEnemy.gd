extends "res://entity/enemy/enemy_base.gd"

const ATTACK_RANGE = 2.5

@onready var anim = $AnimatedSprite3D

func _ready():
	anim.play("default")
	
func target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE
