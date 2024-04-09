extends Node3D

@export var bullet: PackedScene 

var can_shoot : bool = true;

func shoot():
	can_shoot = false
	$"../AttackTimer".start() 
	
	var b = bullet.instantiate()
	b.rotation_degrees = self.global_transform.basis.get_euler() 
	self.add_child(b) 

func _on_clothman_enemy_shoot():
	if can_shoot:
		shoot()
		
func _on_attack_timer_timeout():
	can_shoot = true 
