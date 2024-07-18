extends Control

@onready var health_label = $Health
@onready var flash = $ScreenTint
@onready var player = get_tree().get_first_node_in_group("player"); 

var prompts_enabled = true

func _ready():
	_on_player_hp_change()

func _on_player_hp_change():
	health_label.text = str(player.hp)
	if (player.hp <= 25):
		health_label.text = "[shake rate=20.0 level=" + str(50 - player.hp) + " connected=1]" + str(player.hp) + "[/shake]"
	if (player.hp < 0):
		player.hp = 0

func _on_player_player_healed():
	var tween = get_tree().create_tween()
	flash.color = Color(0.15, 0.73, 0.32)
	flash.visible = true;  
	
	await tween.tween_property(flash, "modulate:a", 0.5, 0.25).finished
	var tween2 = get_tree().create_tween()
	await tween2.tween_property(flash, "modulate:a", 0.0, 0.25).finished
	flash.visible = false; 

func _on_player_player_hit():
	var tween = get_tree().create_tween()
	flash.color = Color(0.67, 0.04, 0) 
	
	flash.visible = true;  
	await tween.tween_property(flash, "modulate:a", 0.5, 0.125).finished
	var tween2 = get_tree().create_tween()
	await tween2.tween_property(flash, "modulate:a", 0.0, 0.125).finished
	flash.visible = false; 
