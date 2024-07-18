extends "res://entity/entity_base.gd"

#constants
const BOB_FREQ = 2.0
const BOB_AMP = 0.06
const JUMP_VELOCITY = 4
const SENSITIVITY = 0.003
const MELEE_DAMAGE = 25 

#variables 
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var old_vel : float = 0.0
var t_bob = 0.0
var can_play : bool = true #relates to sounds 
var dead = false 
var key_inventory : Array[Node3D]

# nodes  
@onready var head = $Head
@onready var camera = %Player_camera
@onready var subviewport_camera = %Subviewport_camera
@onready var melee_anim = $SwordAnimPlayer
@onready var hitbox = $Head/Player_camera/Hitbox
@onready var sound_manager = $SoundManager
@onready var interact_ray = $Head/Player_camera/Hitbox/InteractRay

#signals
signal player_hit
signal player_healed
signal step 
signal fall 
signal player_dead

func _ready():
	dead = false 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	SPEED = 5.0
	
func _unhandled_input(event): #mouse rotation
	if dead:
		return 
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY) #rotates around y axis
		camera.rotate_x(-event.relative.y * SENSITIVITY) #rotates around x axis
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80)) #limits camera 
		
func _process(_delta):
	if dead:
		return
		
	subviewport_camera.set_global_transform(camera.get_global_transform())
	
func _physics_process(delta):
	if dead:
		return
		
	# Adds gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta 

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "forward", "backward") #input maps set to keys 
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED 
		velocity.z = direction.z * SPEED
	else: #not moving 
		velocity.x = lerp(velocity.x, direction.x * SPEED, delta * 7.0)
		velocity.z =  lerp(velocity.z, direction.z * SPEED, delta * 7.0)

	#Headbob 
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	_rotate_step_up_separation_ray()
	move_and_slide()
	_snap_down_to_stairs_check()
	melee()
	tryInteract()
	
	var diff = velocity.y - old_vel
	if diff > 3:
		emit_signal("fall")
	old_vel = velocity.y

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	
	#synced footsteps
	var low_pos = BOB_AMP - 0.05
	if pos.y > -low_pos:
		can_play = true; 
		
	if pos.y < -low_pos and can_play:
		can_play = false
		emit_signal("step")
		
	return pos 


#stair handling
var _was_on_floor_last_frame = false
var _snapped_to_stairs_last_frame = false 

func _snap_down_to_stairs_check():
	var did_snap = false 
	if not is_on_floor() and velocity.y <= 0 and (_was_on_floor_last_frame or _snapped_to_stairs_last_frame) and $StairsBelowRayCast3D.is_colliding():
		var body_test_result = PhysicsTestMotionResult3D.new()
		var params = PhysicsTestMotionParameters3D.new()
		var max_step_down = -0.5
		params.from = self.global_transform
		params.motion = Vector3(0, max_step_down, 0)
		if PhysicsServer3D.body_test_motion(self.get_rid(), params, body_test_result):
			var translate_y = body_test_result.get_travel().y
			self.position.y += translate_y
			apply_floor_snap()
			did_snap = true
		
	_was_on_floor_last_frame = is_on_floor() 
	_snapped_to_stairs_last_frame = did_snap


@onready var _initial_separation_ray_dist = abs($StepUpSeparationRay_F.position.z)

func _rotate_step_up_separation_ray():
	var xz_vel = velocity * Vector3(1, 0, 1)
	var xz_f_ray_pos = xz_vel.normalized() * _initial_separation_ray_dist
	$StepUpSeparationRay_F.global_position.x = self.global_position.x + xz_f_ray_pos.x
	$StepUpSeparationRay_F.global_position.z = self.global_position.z + xz_f_ray_pos.z
	
#attack handling
func melee(): 
	if Input.is_action_just_pressed("fire"):
		if not melee_anim.is_playing():
			melee_anim.play("Attack")
			melee_anim.queue("Return")

func meleeHit():
	for body in hitbox.get_overlapping_bodies():
		var hit_pos = body
		if body.is_in_group("enemies"):
			body.take_damage(MELEE_DAMAGE)
			body.hitflash() 
			body.apply_knockback(body.global_transform.origin - global_transform.origin)
			sound_manager.play_hit(hit_pos)
		if body.is_in_group("destructible"):
			sound_manager.play_break()
			body.destroy()
		if body.is_in_group("environment"):
			sound_manager.play_wall_hit(hit_pos) 
			

func tryInteract():
	if interact_ray.is_colliding():
		var collider = interact_ray.get_collider()
		if collider.is_in_group("interactable"):
			if Input.is_action_just_pressed("interact"):
				if collider.is_in_group("key"):
					key_inventory.append(collider.get_parent_node_3d())
					collider.get_parent_node_3d().pickup()
				else:
					collider.use()

func hit(dir, dmg):
	take_damage(dmg)
	velocity += dir * 4.0
	emit_signal("player_hit") 
		
func heal_to(new_hp):
	set_hp(new_hp)
	emit_signal("player_healed")

func hasKey(key):
	if(key_inventory.has(key)):
		return true
	else:
		return false

func die():
	await get_tree().create_timer(0.25).timeout
	dead = true 
	emit_signal("player_dead")
		
func _on_scene_transition_reset_player():
	hp = hp_max 
	key_inventory.clear() 
	dead = false 
	velocity = Vector3(0,0,0)
	$SwordOverlay.visible = true
