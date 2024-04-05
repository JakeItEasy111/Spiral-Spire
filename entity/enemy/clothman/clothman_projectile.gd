extends Area3D

var dir = Vector3()

func _ready() -> void:
	top_level = true; 

func _process(delta):
	translate(-(transform.basis.x * 150 * delta))

func _on_clothmanprojectile_body_entered(body: Node) -> void:
	if body.is_in_group("entity"):
		body.take_damage(15)
	
	queue_free() 

func _on_BulletTimer_timeout() -> void:
	queue_free() 
