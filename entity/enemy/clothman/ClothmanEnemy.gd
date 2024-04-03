extends "res://entity/enemy/enemy_base.gd"

@onready var state_machine
@onready var anim_tree = $MeshInstance3D/clothman/AnimationTree

func _ready(): 
	state_machine = anim_tree.get("parameters/playback")
	
func _process(delta):
	match state_machine.get_current_node():
		"Fly":
			SPEED = 1
		"Attack":
			SPEED = 0
		
	anim_tree.set("parameters/conditions/attack", _can_see_target() && _target_in_range())
	anim_tree.set("parameters/conditions/run", _target_in_range())

func die():
	dead = true 
	anim_tree.set("parameters/conditions/die", true)
	await get_tree().create_timer(2.0).timeout
	queue_free()
