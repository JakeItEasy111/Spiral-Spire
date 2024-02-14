extends "res://entity/enemy/enemy_base.gd"

const ATTACK_RANGE = 2.5

@onready var fire_anim = $AnimatedSprite3D 
@onready var anim_tree = $MeshInstance3D/wicker/AnimationTree
@onready var emitter = $MeshInstance3D/wicker/Armature/Skeleton3D/Emitter
@onready var state_machine

func _ready():
	SPEED = 3 
	fire_anim.play("default")
	state_machine = anim_tree.get("parameters/playback")

func _process(delta):
	match state_machine.get_current_node():
		"wicker_walk":
			SPEED = 3
		"wicker_attack":
			SPEED = 0
	
	#animations
	anim_tree.set("parameters/conditions/attack", _target_in_range())
	anim_tree.set("parameters/conditions/run", !_target_in_range())
	
	fire_anim.position.y = emitter.position.y - 1
	
	
func _target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE

 
