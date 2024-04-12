extends Node3D

@onready var pickup_area = $Area3D
@onready var player : CharacterBody3D = $"../Player"
const heal_amount = 30

signal player_healed

func _process(delta):
	for body in pickup_area.get_overlapping_bodies():
		if body == player and player.hp < player.hp_max:
			if (body.hp + heal_amount >= body.hp_max):
				body.set_hp(body.hp_max)
			else:
				body.set_hp(body.hp + heal_amount)
			emit_signal("player_healed")
			queue_free()
