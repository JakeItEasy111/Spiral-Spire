extends CanvasLayer

@onready var player = get_tree().get_first_node_in_group("player")
@onready var world = get_parent()
@onready var current_level = get_tree().get_first_node_in_group("level")
@onready var current_level_path = "res://levels/dungeons/floor_one.tscn"
var in_transition = false 

signal reset_player

func transition_level(level, path):
	get_tree().paused = true 
	$"../UILayer".visible = false
	$AnimationPlayer.play("dissolve")
	$AudioStreamPlayer2D.play() 
	await $AnimationPlayer.animation_finished
	load_level(level, path)
	in_transition = true 

func load_level(level, path):
	level.queue_free()
	level = load(path).instantiate() 
	current_level = level 
	current_level_path = path 
	add_child(level)
	player.position = Vector3.ZERO

func restart_level():
	load_level(current_level, current_level_path)
	emit_signal("reset_player")
	
func _process(_delta):
	if(in_transition):
		$TextureRect.modulate = Color(1, 1, 1, 1)
		if Input.is_action_just_pressed("space"):
			get_tree().paused = false
			$AnimationPlayer.play_backwards("dissolve")
			in_transition = false
			$"../UILayer".visible = true 

