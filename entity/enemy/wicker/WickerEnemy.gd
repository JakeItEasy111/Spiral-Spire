extends "res://entity/enemy/enemy_base.gd"

const ATTACK_RANGE = 2.5

@onready var anim_tree = $MeshInstance3D/AnimationTree
@onready var anim_player = $MeshInstance3D/AnimationPlayer
@onready var particle = $GPUParticles3D
@onready var state_machine
@onready var fire_anim = $MeshInstance3D/Armature/Skeleton3D/Wicker/AnimatedSprite3D
@onready var attack_sfx = $AttackSFX
@onready var ambient_sfx = $AmbientSFX
@onready var death_sfx = $DeathSFX

func _ready():
	hp = 75
	fire_anim.play("default")
	ambient_sfx.pitch_scale = randf_range(0.8, 1.2)
	ambient_sfx.play() 
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

func _play_attack_sfx():
	attack_sfx.pitch_scale = randf_range(0.8, 1.2)
	attack_sfx.play()

func play_death_sfx():
	death_sfx.pitch_scale = randf_range(0.8, 1.2)
	death_sfx.play()
	
func hitflash(): 
	var tween = get_tree().create_tween()
	var body = $MeshInstance3D/Armature/Skeleton3D/Cylinder/Cylinder.get_active_material(0)
	var legs = $MeshInstance3D/Armature/Skeleton3D/Wicker/Wicker.get_active_material(0)
	tween.tween_property(fire_anim, "transparency", 1.0, 0.05)
	tween.tween_property(body, "emission", Color.WHITE, 0.05)
	tween.tween_property(legs, "emission", Color.WHITE, 0.05)
	tween.tween_property(fire_anim, "transparency", 0, 0.05)
	tween.tween_property(legs, "emission", Color.BLACK, 0.05)
	tween.tween_property(body, "emission", Color.BLACK, 0.05)

func die():
	anim_tree.set("parameters/conditions/die", true)
	await get_tree().create_timer(1.0).timeout
	$OmniLight3D.visible = false 
	await get_tree().create_timer(2.0).timeout 
	queue_free()
