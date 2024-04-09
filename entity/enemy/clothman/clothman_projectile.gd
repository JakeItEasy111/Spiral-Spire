extends Area3D

var dir = Vector3()
const BULLET_SPEED = 6

func _ready() -> void:
	top_level = true; 
	$AnimatedSprite3D.play()

func _process(delta):
	position -= transform.basis.z * delta * BULLET_SPEED

func _on_BulletTimer_timeout() -> void:
	queue_free() 

func _on_body_entered(body):
	if body.is_in_group("player"): 
		var dir = body.global_transform.origin - global_transform.origin
		body.hit(dir, 10)
		queue_free() 
