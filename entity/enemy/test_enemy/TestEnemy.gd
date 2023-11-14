extends "res://entity/enemy/enemy_base.gd"

const ATTACK_RANGE = 2.5

func target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE
