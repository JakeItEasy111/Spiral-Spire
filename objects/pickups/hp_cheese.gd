extends Node3D

@onready var pickup_area = $Area3D
@onready var eat_sfx = $EatSFX
const HEAL_AMOUNT = 15

func _process(delta):
	for body in pickup_area.get_overlapping_bodies():
		if body.is_in_group("player") and body.hp < body.hp_max:
			if (body.hp + HEAL_AMOUNT >= body.hp_max):
				body.heal_to(body.hp_max)
			else:
				body.heal_to(body.hp + HEAL_AMOUNT)
			despawn() 
			set_process(false)

func despawn():
	eat_sfx.play()
	$Area3D.queue_free()
	await get_tree().create_timer(0.5).timeout
	queue_free()
