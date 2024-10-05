extends Node

@onready var color := Global.get_random_doll_color()
@onready var pattern := Global.get_random_doll_pattern()
@onready var head_shape := Global.get_random_doll_headshape()
@onready var eyes := Global.get_random_doll_eyes()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
