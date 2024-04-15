extends Area3D

var dir = Vector3()
var kill = false 
@onready var proj_anim = $ProjectileSprite
@onready var proj_kill_anim = $BurstEffect

const BULLET_SPEED = 5
const BULLET_DAMAGE = 5 

func _ready() -> void:
	top_level = true; 
	proj_anim.play()

func _process(delta):
	if !kill:
		position -= transform.basis.z * delta * BULLET_SPEED

func _on_BulletTimer_timeout() -> void:
	queue_free() 

func _on_body_entered(body):
	if body.is_in_group("player"): 
		var dir = body.global_transform.origin - global_transform.origin
		body.hit(dir, BULLET_DAMAGE)
		kill_effect() 
		await get_tree().create_timer(0.75).timeout
		queue_free() 
	elif !body.is_in_group("entity"):
		kill_effect() 
		await get_tree().create_timer(0.75).timeout
		queue_free()

func kill_effect():
	kill = true 
	proj_anim.visible = false 
	proj_kill_anim.visible = true 
	proj_kill_anim.play()
