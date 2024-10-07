extends Node

var color := Global.get_random_doll_color()
var pattern := Global.get_random_doll_pattern()
var head_shape := Global.get_random_doll_headshape()
var eyes := Global.get_random_doll_eyes()
var eyes_count : int = [1,2,3].pick_random()

var given_color := GameData.DollColor.NONE
var given_pattern := GameData.DollPattern.NONE
var given_head := GameData.DollHeadShape.NONE
var given_eyes := GameData.DollEyes.NONE
var given_eyes_count := 0

@onready var sprite_normal := $SpriteNode/SpriteNormal
@onready var sprite_crumpled := $SpriteNode/SpriteCrumpled

@onready var eyes_label := $SpriteNode/SpriteNormal/EyesLabel
@onready var pattern_label := $SpriteNode/SpriteNormal/PatternLabel
@onready var color_label := $SpriteNode/SpriteNormal/ColorLabel
@onready var head_label := $SpriteNode/SpriteNormal/HeadLabel

@onready var anim_player := $AnimationPlayer

var mixer_over_me : Node2D

var mixer_inside_me : Node2D # used after a mixer is assigned to this order
# then checks if the mixer matches the order

@onready var area := $SpriteNode/Area2D

var scale_normal := Vector2(1, 1)
var scale_hovering := Vector2(1.25, 1.25)

var mouse_inside := false
var index_in_main_order_array := 0

@onready var progress_bar : ProgressBar = $SpriteNode/SpriteCrumpled/ProgressBar
@onready var life_timer : Timer = $OrderLifeTimer

var force_show := false


# Called when the node enters the scene tree for the first time.
func _ready():
	progress_bar.get_theme_stylebox("fill").bg_color = Color(0.4, 0.1, 0.0)
	
	pattern_label.text = "pattern: " + str(pattern)
	color_label.text = "color: " + str(color)
	eyes_label.text = "eyes: " + str(eyes)
	head_label.text = "head: " + str(head_shape)
	
	$SpriteNode/SpriteNormal/FabricSprite.modulate = GameData.doll_colors[color]
	match pattern:
		GameData.DollPattern.STRIPE:
			$SpriteNode/SpriteNormal/FabricSprite/Pattern.texture = load("res://sprites/stripes.png")
		GameData.DollPattern.POLKA:
			$SpriteNode/SpriteNormal/FabricSprite/Pattern.texture = load("res://sprites/polka.png")
		GameData.DollPattern.GRID:
			$SpriteNode/SpriteNormal/FabricSprite/Pattern.texture = load("res://sprites/plaid.png")
	
	$SpriteNode/SpriteNormal/HeadSprite/SpriteBear.hide()
	$SpriteNode/SpriteNormal/HeadSprite/SpriteCat.hide()
	$SpriteNode/SpriteNormal/HeadSprite/SpriteFrog.hide()
	
	match head_shape:
		GameData.DollHeadShape.BEAR:
			$SpriteNode/SpriteNormal/HeadSprite/SpriteBear.show()
		GameData.DollHeadShape.KITTO:
			$SpriteNode/SpriteNormal/HeadSprite/SpriteCat.show()
		GameData.DollHeadShape.FROG:
			$SpriteNode/SpriteNormal/HeadSprite/SpriteFrog.show()
			
	$SpriteNode/SpriteNormal/EyeCountLabel.text = "x " + str(eyes_count)
	$SpriteNode/SpriteNormal/MaterialCountLabel.text = "x 2"

	
	life_timer.wait_time = GameData.order_life_time
	progress_bar.max_value = GameData.order_life_time
	
	life_timer.start()
	
	anim_player.play("order_swoop_in")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	index_in_main_order_array = get_index_in_array()
	
	self.global_position.x = lerp(
		self.global_position.x,
		calculate_x(),
		.15
	)
	
	progress_bar.value = life_timer.time_left
	
	var i_am_the_chosen_one : bool = (mixer_over_me && mixer_over_me.hovering_over_order == self)
	
	if i_am_the_chosen_one || mouse_inside || force_show:
		sprite_normal.show()
		sprite_crumpled.hide()
	else:
		sprite_normal.hide()
		sprite_crumpled.show()
		
		
	self.scale = lerp(self.scale, scale_hovering if i_am_the_chosen_one else scale_normal, .2)
	
	if !Global.dragging_something and i_am_the_chosen_one and !mixer_inside_me:
		animate_then_delete()
		
		var _y = Global.window_size.y + 100
		mixer_over_me.global_position = Vector2(mixer_over_me.old_snap_x, _y)
		mixer_over_me.emit_puff_particles()
		
		self.mixer_inside_me = mixer_over_me
		self.given_color = mixer_inside_me.color
		self.given_pattern = mixer_inside_me.pattern
		self.given_head = mixer_inside_me.head_shape
		self.given_eyes = mixer_inside_me.eyes
		self.given_eyes_count = mixer_inside_me.eyes_count
		self.mixer_inside_me.reset_mix()


func animate_then_delete() -> void:
	var index := get_index_in_array()
	Global.main.orders.remove_at(index)
	anim_player.play("order_remove")


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


func check_order() -> float:
	var score := 0.0
	
	if self.color == self.given_color:
		score += 0.2
	if self.pattern == self.given_pattern:
		score += 0.2
	if self.head_shape == self.given_head:
		score += 0.2
	if self.eyes == self.given_eyes:
		score += 0.2
	if self.eyes_count == self.given_eyes_count:
		score += 0.2
	
	return score


func _on_area_2d_area_entered(area):
	if area.is_in_group('mixer'):
		mixer_over_me = area.get_parent()


func _on_area_2d_area_exited(area):
	if area.is_in_group('mixer'):
		mixer_over_me = area.get_parent()


func _on_area_2d_mouse_entered():
	print("color: ", color, ", pattern: ", pattern, ", head: ", head_shape, ", eyes: ", eyes, ", #eyes: ", eyes_count)
	mouse_inside = true
	

func _on_area_2d_mouse_exited():
	mouse_inside = false


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "order_remove":
		print("score : ", check_order())
		Global.main.order_completed()
		queue_free()


func _on_order_life_timer_timeout():
	force_show = true
	animate_then_delete()
