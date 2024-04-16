extends Node3D

enum DOOR_STATES {
	closed,
	opened
}

enum OPEN_DIRECTIONS {
	closed,
	front,
	rear
}

@onready var open_sfx = $OpenSFX
@onready var close_sfx = $CloseSFX
@onready var unlock_sfx = $UnlockSFX
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")

var door_state = DOOR_STATES.closed
var open_direction = OPEN_DIRECTIONS.closed 
var locked 

@export var open_angle_front = 90 
@export var open_angle_rear = -90
@export var start_angle = 90
@export var key : Node3D

func _ready():
	if(key == null):
		locked = false
	else:
		locked = true 
		
func _process(delta : float) -> void:
	match door_state:
		DOOR_STATES.closed:
			rotation_degrees.y = lerpf(rotation_degrees.y, start_angle, delta * 6)
		DOOR_STATES.opened:
			if open_direction == OPEN_DIRECTIONS.front:
				rotation_degrees.y = lerpf(rotation_degrees.y, open_angle_front, delta * 3)
			if open_direction == OPEN_DIRECTIONS.rear:
				rotation_degrees.y = lerpf(rotation_degrees.y, open_angle_rear, delta * 3)

func open(dir : int):
	if (not locked):
		if door_state == DOOR_STATES.closed:
			door_state = DOOR_STATES.opened
			open_direction = dir
			open_sfx.play()
			return
		if door_state == DOOR_STATES.opened:
			door_state = DOOR_STATES.closed
			open_direction = dir 
			close_sfx.play()
			return
	elif(player.hasKey(key)):
		locked = false
		unlock_sfx.play() 

func _on_open_door_front_open() -> void:
	open(OPEN_DIRECTIONS.front)
	
func _on_open_door_rear_open() -> void:
	open(OPEN_DIRECTIONS.rear)
