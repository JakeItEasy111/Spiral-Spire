extends Node3D

@export var sword_sounds : Array[AudioStreamMP3]
@export var camera : Node3D
@export var player : CharacterBody3D = get_parent() 

func _ready():
	camera = %Player_camera
	
func play_sound():
	var audio_player : AudioStreamPlayer3D = AudioStreamPlayer3D.new()
	var random_index : int = randi_range(0, sword_sounds.size() - 1)
	audio_player.stream = sword_sounds[random_index]
	audio_player.pitch_scale = randf_range(0.8, 1.2)
	camera.add_child(audio_player)
	audio_player.play()
	audio_player.finished.connect(func destroy(): audio_player.queue_free())
