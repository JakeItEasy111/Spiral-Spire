extends Node3D

@onready var pickup_area = $Area3D
@onready var player : CharacterBody3D = $"../Player"

signal player_healed

func _process(delta):
	for body in pickup_area.get_overlapping_bodies():
		if body == player:
			body.set_hp(body.hp + 20)
			emit_signal("player_healed")
			queue_free()
