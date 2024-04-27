extends Node

@export var soundtrack : Array[AudioStreamOggVorbis]
var track_index = 0 

func _ready():
	var audio_player : AudioStreamPlayer3D = AudioStreamPlayer3D.new()
	audio_player.stream = source_sounds[track_index] 
	
