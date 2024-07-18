extends StaticBody3D

@onready var break_sound = $"../../AudioStreamPlayer3D"
@onready var break_particles = $"../../GPUParticles3D"
@onready var colshape = $CollisionShape3D

func destroy():
	get_parent().visible = false
	colshape.disabled = true 
	break_sound.play()
	break_particles.emitting = true
	await break_sound.finished
	get_parent().queue_free()
