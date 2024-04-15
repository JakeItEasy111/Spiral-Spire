extends Node3D

@export var bullet: PackedScene 
@onready var spell_sfx = $"../SpellSfx"
@onready var attack_timer = $"../AttackTimer"

var can_shoot : bool = true;

func shoot():
	can_shoot = false 
	attack_timer.start() 
	
	spell_sfx.pitch_scale = randf_range(0.8, 1.2)
	spell_sfx.play()
	
	var b = bullet.instantiate() 
	b.rotation_degrees = self.global_transform.basis.get_euler() 
	self.add_child(b) 

func _on_clothman_enemy_shoot():
	if can_shoot:
		shoot()
		
func _on_attack_timer_timeout():
	can_shoot = true 
	


