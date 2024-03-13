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

var door_state = DOOR_STATES.closed
var open_direction = OPEN_DIRECTIONS.closed 

@export var open_angle_front = 90 
@export var open_angle_rear = -90
@export var start_angle = 90

func _process(delta : float) -> void:
	match door_state:
		DOOR_STATES.closed:
			rotation_degrees.y = lerpf(rotation_degrees.y, start_angle, delta * 3)
		DOOR_STATES.opened:
			if open_direction == OPEN_DIRECTIONS.front:
				rotation_degrees.y = lerpf(rotation_degrees.y, open_angle_front, delta * 3)
			if open_direction == OPEN_DIRECTIONS.rear:
				rotation_degrees.y = lerpf(rotation_degrees.y, open_angle_rear, delta * 3)

func open(dir : int):
	if door_state == DOOR_STATES.closed:
		door_state = DOOR_STATES.opened
		open_direction = dir
		return
	if door_state == DOOR_STATES.opened:
		door_state = DOOR_STATES.closed
		open_direction = dir 
		return

func _on_open_door_front_open() -> void:
	open(OPEN_DIRECTIONS.front)
	
func _on_open_door_rear_open() -> void:
	open(OPEN_DIRECTIONS.rear)
