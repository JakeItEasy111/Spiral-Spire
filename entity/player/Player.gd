extends "res://entity/entity_base.gd"

#extended movement variables 
const JUMP_VELOCITY = 5
const SENSITIVITY = 0.003

#viewbob variables
const BOB_FREQ = 2.0
const BOB_AMP = 0.06
var t_bob = 0.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") + 2

#sword variables
var melee_damage = 25
@onready var melee_anim = $AnimationPlayer
@onready var hitbox = $Head/Player_camera/Hitbox

#camera variables 
@onready var head = $Head
@onready var camera = %Player_camera
@onready var subviewport_camera = %Subviewport_camera
@onready var health_label = $Health

#signals
signal player_hit


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	SPEED = 5.0
	set_health_label() 
	
func _unhandled_input(event): #mouse rotation
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY) #rotates around y axis
		camera.rotate_x(-event.relative.y * SENSITIVITY) #rotates around x axis
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80)) #limits camera 
		
func _process(delta):
	subviewport_camera.set_global_transform(camera.get_global_transform())
	
func _physics_process(delta):
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
		velocity.x = 0.0
		velocity.z = 0.0

	#Headbob 
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	_rotate_step_up_separation_ray()
	move_and_slide()
	_snap_down_to_stairs_check()
	melee()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
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
		if body.is_in_group("enemies"):
			body.hp -= melee_damage 
			body.velocity += global_position.direction_to(body.global_position) * 8.0
		
#health handling
func set_health_label(): #change to bar, add to base?
	health_label.text = str(hp)
	
func take_damage(dmg):
	super.take_damage(dmg)
	health_label.text = str(hp)
	if (hp <= 25):
		health_label.text = "[shake rate=20.0 level=" + str(50 - hp) + " connected=1]" + str(hp) + "[/shake]"

func hit(dmg, dir):
		take_damage(dmg)
		emit_signal("player_hit") #surprise tool that will help us later! used for on hit screen effects
		velocity += dir * 8.0
	
func _on_area_3d_body_entered(body): #for projectiles and area hazards 
	take_damage(10)  #if area.is_in_group("groupName") for changing damage based on type 
