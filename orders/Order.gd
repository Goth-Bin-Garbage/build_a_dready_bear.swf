extends Node

@onready var color : GameData.DollColor = Global.get_random_doll_color()
@onready var pattern : GameData.DollPattern = Global.get_random_doll_pattern()
@onready var head_shape : GameData.DollHeadShape = Global.get_random_doll_headshape()
@onready var eyes : GameData.DollEyes = Global.get_random_doll_eyes()

@onready var my_color : Color = Global.get_doll_color(color)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
