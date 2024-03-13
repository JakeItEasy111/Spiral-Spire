extends Area3D

@onready var pickup_sound = $"../PickupSound"

func use():
	get_parent().queue_free()
