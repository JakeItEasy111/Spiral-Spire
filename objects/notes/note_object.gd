extends Node3D

@export var note_text : String
@onready var text_label = $NoteLayer/NoteUI/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	text_label.text = note_text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
