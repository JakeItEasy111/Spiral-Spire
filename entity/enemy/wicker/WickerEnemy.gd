extends "res://entity/enemy/enemy_base.gd"

const ATTACK_RANGE = 2.0

@onready var fire_anim = $MeshInstance3D/Armature/Skeleton3D/Wicker/AnimatedSprite3D
@onready var anim_tree = $MeshInstance3D/AnimationTree
@onready var particle = $GPUParticles3D
@onready var state_machine
var time : float 

func _ready():
	SPEED = 3 
	fire_anim.play("default")
	state_machine = anim_tree.get("parameters/playback")

func _process(delta):
	match state_machine.get_current_node():
		"wicker_walk":
			SPEED = 3
			particle.emitting = false
		"wicker_attack":		
			SPEED = 0
			particle.emitting = true
			
	#animations
	anim_tree.set("parameters/conditions/attack", _target_in_range())
	anim_tree.set("parameters/conditions/run", !_target_in_range())
	
func _target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE

func _hit_finished():
	if global_position.distance_to(player.global_position) < ATTACK_RANGE + 1.0:
		var dir = global_position.direction_to(player.global_position)
		player.hit(25, dir)
 
