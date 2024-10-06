extends Node

@onready var color := Global.get_random_doll_color()
@onready var pattern := Global.get_random_doll_pattern()
@onready var head_shape := Global.get_random_doll_headshape()
@onready var eyes := Global.get_random_doll_eyes()

@onready var eyes_label := $EyesLabel
@onready var pattern_label := $PatternLabel
@onready var color_label := $ColorLabel
@onready var head_label := $HeadLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pattern_label.text = "pattern: " + str(pattern)
	color_label.text = "color: " + str(color)
	eyes_label.text = "eyes: " + str(eyes)
	head_label.text = "head: " + str(head_shape)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
