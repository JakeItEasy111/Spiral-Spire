extends Node3D

@export var footstep_sounds : Array[AudioStreamMP3]
@export var sword_sounds : Array[AudioStreamMP3]
@export var hurt_sounds : Array[AudioStreamMP3]
@export var hit_sound : Array[AudioStreamMP3]
@export var fall_sounds : Array[AudioStreamMP3]
@export var break_sound : Array[AudioStreamMP3]
@export var camera : Node3D
@export var ground_pos : Marker3D
@export var player : CharacterBody3D = get_parent() 

# Called when the node enters the scene tree for the first time.
func _ready():
	player.step.connect(play_footstep)
	player.player_hit.connect(play_hurt)
	player.fall.connect(play_fall)
	camera = %Player_camera
	
func play_sound(source_sounds, play_pos):
	var audio_player : AudioStreamPlayer3D = AudioStreamPlayer3D.new()
	var random_index : int = randi_range(0, source_sounds.size() - 1)
	audio_player.stream = source_sounds[random_index]
	audio_player.pitch_scale = randf_range(0.8, 1.2)
	play_pos.add_child(audio_player)
	audio_player.play()
	audio_player.finished.connect(func destroy(): audio_player.queue_free())

func play_footstep():
	play_sound(footstep_sounds, ground_pos) 

func sword_swoosh():
	play_sound(sword_sounds, camera)

func play_hurt():
	play_sound (hurt_sounds, camera)
	
func play_hit(hit_pos):
	play_sound(hit_sound, hit_pos)
	
func play_fall():
	play_sound(fall_sounds, ground_pos)
	
func play_break():
	play_sound(break_sound, camera)
