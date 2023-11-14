extends "res://entity/entity_base.gd"

@onready var nav_agent = $NavigationAgent3D
@onready var player : CharacterBody3D = $"../Player"

func _physics_process(delta):
	velocity = Vector3.ZERO
	
	#navigation
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity = new_velocity
	
	look_at(Vector3(player.global_position.x, player.global_position.y, player.global_position.z), Vector3.UP)
	move_and_slide()  
	
func set_target_position(target_location):
	nav_agent.target_position = target_location
