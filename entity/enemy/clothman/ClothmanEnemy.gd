extends "res://entity/enemy/enemy_base.gd"

@onready var state_machine
@onready var anim_tree = $MeshInstance3D/clothman/AnimationTree
@onready var death_anim = $DeathAnim
@onready var hitflash_anim = $MeshInstance3D/clothman/Hitflash

signal shoot 

func _ready(): 
	state_machine = anim_tree.get("parameters/playback")
	
func _process(delta):
	match state_machine.get_current_node():
		"Fly":
			SPEED = 1
		"Attack":
			SPEED = 0
			emit_signal("shoot")
			
	anim_tree.set("parameters/conditions/attack", _can_see_target())
	anim_tree.set("parameters/conditions/run", !_can_see_target() or !_target_in_range())

func hitflash():
	hitflash_anim.play("hitflash")

func die():
	dead = true 
	anim_tree.set("parameters/conditions/die", true)
	await get_tree().create_timer(1.5).timeout
	death_anim.visible = true 
	death_anim.play()
	$MeshInstance3D/clothman.visible = false 
	await get_tree().create_timer(1.0).timeout
	queue_free()
