extends CanvasLayer

@onready var player = get_tree().get_first_node_in_group("player")
@onready var world = get_parent()
var in_transition = false 

signal connect_level(level)

func change_level_scene(level, path):
	get_tree().paused = true 
	$"../UILayer".visible = false
	level.queue_free()
	level = load(path).instantiate() 
	
	$AnimationPlayer.play("dissolve")
	$AudioStreamPlayer2D.play() 
	await $AnimationPlayer.animation_finished
	in_transition = true 

	add_child(level)
	player.position = Vector3.ZERO

func change_level_no_transition(level, path):
	level.queue_free()
	level = load(path).instantiate() 
	add_child(level)
	player.position = Vector3.ZERO
	
func _process(delta):
	if(in_transition):
		$TextureRect.modulate = Color(1, 1, 1, 1)
		if Input.is_action_just_pressed("space"):
			get_tree().paused = false
			$AnimationPlayer.play_backwards("dissolve")
			in_transition = false
			$"../UILayer".visible = true 

