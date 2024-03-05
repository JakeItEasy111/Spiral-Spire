extends "res://entity/enemy/enemy_base.gd"

const ATTACK_RANGE = 2.5

@onready var anim_tree = $MeshInstance3D/AnimationTree
@onready var anim_player = $MeshInstance3D/AnimationPlayer
@onready var particle = $GPUParticles3D
@onready var state_machine
@onready var fire_anim = $MeshInstance3D/Armature/Skeleton3D/Wicker/AnimatedSprite3D

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
			if (_target_in_range()):
				anim_player.get_animation("wicker_attack").loop_mode =  (Animation.LOOP_LINEAR)
			else:
				anim_player.get_animation("wicker_attack").loop_mode =  (Animation.LOOP_NONE)
			
	#animations
	anim_tree.set("parameters/conditions/attack", _target_in_range())
	anim_tree.set("parameters/conditions/run", !_target_in_range())
	
func _target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE

func _hit_finished():
	if global_position.distance_to(player.global_position) < ATTACK_RANGE + 1.0:
		var dir = player.global_transform.origin - global_transform.origin
		player.hit(dir, 20)
		
func hitflash(): #WIP 
	var tween = get_tree().create_tween()
	var material = $MeshInstance3D/Armature/Skeleton3D/Cylinder/Cylinder.get_active_material(0)
	tween.tween_property(material, "emission", Color.WHITE, 0.1)
	tween.tween_property(material, "emission", Color.BLACK, 0.1)
