extends "res://entity/entity_base.gd"

@onready var nav_agent = $NavigationAgent3D
@onready var player : CharacterBody3D = $"../Player"
@onready var knockback_force : Vector3 = Vector3.ZERO
@onready var sight_rays = [$PlayerDetectRay, $PlayerDetectRay2, $PlayerDetectRay3]
@export var detect_range : int 
@onready var dead = false 

func _physics_process(delta):
	if not dead: 
		velocity = Vector3.ZERO
		knockback_force *= 0.95
		
		#navigation
		if(_target_in_range()):
			var current_location = global_transform.origin
			var next_location = nav_agent.get_next_path_position()
			var new_velocity = (next_location - current_location).normalized() * SPEED
			velocity.x = new_velocity.x + knockback_force.x
			velocity.z = new_velocity.z + knockback_force.z
				
		look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
		move_and_slide()  

func _target_in_range():
	return global_position.distance_to(player.global_position) < detect_range
	
func set_target_position(target_location):
	nav_agent.target_position = target_location

func _can_see_target():
	for ray in sight_rays:
		if(ray.is_colliding):
			if ray.get_collider() == player:
				return true; 
	
func apply_knockback(force):
	knockback_force = force.normalized() * 8.0 
	
func hitflash():
	pass 
