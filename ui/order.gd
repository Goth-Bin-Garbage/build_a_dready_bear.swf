extends Node

@onready var color := Global.get_random_doll_color()
@onready var pattern := Global.get_random_doll_pattern()
@onready var head_shape := Global.get_random_doll_headshape()
@onready var eyes := Global.get_random_doll_eyes()

@onready var eyes_label := $Sprite2D/EyesLabel
@onready var pattern_label := $Sprite2D/PatternLabel
@onready var color_label := $Sprite2D/ColorLabel
@onready var head_label := $Sprite2D/HeadLabel

@onready var anim_player := $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pattern_label.text = "pattern: " + str(pattern)
	color_label.text = "color: " + str(color)
	eyes_label.text = "eyes: " + str(eyes)
	head_label.text = "head: " + str(head_shape)
	
	anim_player.play("order_swoop_in")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.global_position.x = lerp(self.global_position.x, calculate_x(), .2)


# based on order of Global.main.orders
func calculate_x() -> float:
	var found_self := false
	var i := 0
	for order in Global.main.orders:
		if order == self:
			break
		i += 1
	
	# gap between each order
	var _w := 100
	
	# offset for right-most order
	var _o := -50
	
	return Global.window_size.x + _o - _w * i
