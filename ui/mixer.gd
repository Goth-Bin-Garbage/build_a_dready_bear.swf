extends Node2D

# how many mixers can be placed along the bottom of the screen
var mixer_positions : int = 5
var offset_from_bottom : int = 50
var snap_weight : float = 0.15

var mouse_over : bool = false
var dragging : bool = false

var previous_position : Vector2 = global_position

var snap_x : int
var old_snap_x : int

var scale_normal : Vector2 = Vector2(1,1)
var scale_dragging : Vector2 = Vector2(1.5, 1.5)

# properties of the doll being built
# gets compared to contents of order
var color : GameData.DollColor
var pattern : GameData.DollPattern
var head_shape : GameData.DollHeadShape
var eyes : GameData.DollEyes
var eyes_count : int

@onready var area : Area2D = $Area2D
var hovering_over_order : Node2D


func _ready():
	emit_puff_particles()
	adjust_snap_x()


func _process(delta):
	if dragging:
		adjust_snap_x()
		
	scale = lerp(scale, scale_normal if !dragging else scale_dragging, .15)
	
	var areas = area.get_overlapping_areas()
	if Global.dragging_something:
		hovering_over_order = null
		var closest_order = null
		var closest_order_distance = INF
		for a : Area2D in areas:
			if a.is_in_group("order"):
				var order = a.get_parent().get_parent()
				var dist = global_position.distance_to(order.global_position)
				if dist <= closest_order_distance:
					closest_order_distance = dist
					closest_order = order
		hovering_over_order = closest_order
	else:
		for a : Area2D in areas:
			if a.is_in_group("mixer_droppable"):
				var parent = a.get_parent()
				parent.insert_into_mixer(self)
	
	#if Input.is_action_just_released("click"):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if !dragging and mouse_over and !Global.dragging_something:
			print("color: ", color, ", pattern: ", pattern, ", head: ", head_shape, ", eyes: ", eyes, ", #eyes: ", eyes_count)
			old_snap_x = snap_x
			Global.dragging_something = true
			dragging = true
	elif dragging:
		for other_mixer in get_parent().get_children():
			if other_mixer != self and other_mixer.snap_x == snap_x:
				snap_x = old_snap_x
				break
		dragging = false
		Global.dragging_something = false
	
	if dragging:
		global_position = get_viewport().get_mouse_position()
	else:
		global_position = lerp(
			global_position,
			Vector2(snap_x, Global.window_size.y - offset_from_bottom),
			snap_weight
		)
	
	rotation = lerp(rotation, (global_position.x - previous_position.x) * .05, .05)
	
	previous_position = global_position


func adjust_snap_x():
	var _snap_width = Global.window_size.x / (mixer_positions+1)
	snap_x = clamp(
		round(global_position.x / _snap_width) * _snap_width,
		_snap_width,
		Global.window_size.x - _snap_width
	)


# returns true/false if successful
func update_doll_color_pattern(c : GameData.DollColor, p : GameData.DollPattern) -> bool:
	if color == GameData.DollColor.NONE && pattern == GameData.DollPattern.NONE:
		color = c
		pattern = p
		emit_light_puff_particles()
		return true
	return false


func update_doll_head(h : GameData.DollHeadShape) -> bool:
	if head_shape == GameData.DollHeadShape.NONE:
		head_shape = h
		emit_light_puff_particles()
		return true
	return false


func update_doll_eyes(e : GameData.DollEyes) -> bool:
	if eyes == GameData.DollEyes.NONE:
		eyes = e
		emit_light_puff_particles()
		return true
	return false


func update_doll_eyes_count() -> void:
	emit_light_puff_particles()
	eyes_count += 1


func _on_area_2d_mouse_entered():
	mouse_over = true


func _on_area_2d_mouse_exited():
	mouse_over = false


func emit_puff_particles():
	$ParticlesDarkPuff.emitting = true
	

func emit_light_puff_particles():
	$ParticlesLightPuff.emitting = true


func reset_mix():
	color = GameData.DollColor.NONE
	pattern = GameData.DollPattern.NONE
	head_shape = GameData.DollHeadShape.NONE
	eyes = GameData.DollEyes.NONE
	eyes_count = 0
