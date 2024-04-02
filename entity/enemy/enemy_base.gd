extends "res://entity/entity_base.gd"

@onready var nav_agent = $NavigationAgent3D
@onready var player : CharacterBody3D = $"../Player"
@onready var knockback_force : Vector3 = Vector3.ZERO

func _physics_process(delta):
	velocity = Vector3.ZERO
	knockback_force *= 0.95
	
	#navigation
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity.x = new_velocity.x + knockback_force.x
	velocity.z = new_velocity.z + knockback_force.z
		
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	move_and_slide()  
	
func set_target_position(target_location):
	nav_agent.target_position = target_location
	
func apply_knockback(force):
	knockback_force = force.normalized() * 8.0 
	
func hitflash():
	pass 
	
