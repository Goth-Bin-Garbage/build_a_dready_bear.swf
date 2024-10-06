extends Node

@onready var color := Global.get_random_doll_color()
@onready var pattern := Global.get_random_doll_pattern()
@onready var head_shape := Global.get_random_doll_headshape()
@onready var eyes := Global.get_random_doll_eyes()

@onready var sprite_normal := $SpriteNode/SpriteNormal
@onready var sprite_crumpled := $SpriteNode/SpriteCrumpled

@onready var eyes_label := $SpriteNode/SpriteNormal/EyesLabel
@onready var pattern_label := $SpriteNode/SpriteNormal/PatternLabel
@onready var color_label := $SpriteNode/SpriteNormal/ColorLabel
@onready var head_label := $SpriteNode/SpriteNormal/HeadLabel

@onready var anim_player := $AnimationPlayer

@onready var mixer_over_me : Node2D

@onready var area := $SpriteNode/Area2D

@onready var scale_normal := Vector2(1, 1)
@onready var scale_hovering := Vector2(1.25, 1.25)

var mouse_inside := false
var index_in_main_order_array := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pattern_label.text = "pattern: " + str(pattern)
	color_label.text = "color: " + str(color)
	eyes_label.text = "eyes: " + str(eyes)
	head_label.text = "head: " + str(head_shape)
	
	anim_player.play("order_swoop_in")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	index_in_main_order_array = get_index_in_array()
	
	self.global_position.x = lerp(
		self.global_position.x,
		calculate_x(),
		.15
	)
	
	var i_am_the_chosen_one : bool = (mixer_over_me && mixer_over_me.hovering_over_order == self)
	
	if i_am_the_chosen_one || mouse_inside:
		sprite_normal.show()
		sprite_crumpled.hide()
	else:
		sprite_normal.hide()
		sprite_crumpled.show()
		
		
	self.scale = lerp(self.scale, scale_hovering if i_am_the_chosen_one else scale_normal, .2)
	
	if !Global.dragging_something and i_am_the_chosen_one:
		var index := get_index_in_array()
		Global.main.orders[index].queue_free()
		Global.main.orders.remove_at(index)
		
		var _y = Global.window_size.y + 100
		mixer_over_me.global_position = Vector2(mixer_over_me.old_snap_x, _y)
		mixer_over_me.emit_puff_particles()



func get_index_in_array() -> int:
	var i := 0
	for order in Global.main.orders:
		if order == self:
			break
		i += 1
	return i


# based on order of Global.main.orders
func calculate_x() -> float:
	var i := index_in_main_order_array
	
	# gap between each order
	var _w := 115
	
	# offset for right-most order
	var _o := -50
	
	return Global.window_size.x + _o - _w * i


func _on_area_2d_area_entered(area):
	if area.is_in_group('mixer'):
		mixer_over_me = area.get_parent()


func _on_area_2d_area_exited(area):
	if area.is_in_group('mixer'):
		mixer_over_me = area.get_parent()


func _on_area_2d_mouse_entered():
	mouse_inside = true
	

func _on_area_2d_mouse_exited():
	mouse_inside = false
