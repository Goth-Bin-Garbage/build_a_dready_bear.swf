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
var material_stuffing_count : int
var material_skin_count : int

@onready var area : Area2D = $Area2D
var hovering_over_order : Node2D

@onready var mixer_contents : Sprite2D = $MixerContents
@onready var mixer_contents_scale := mixer_contents.scale.x
@onready var mixer_contents_scale_max := mixer_contents_scale


func _ready():
	emit_puff_particles()
	adjust_snap_x()


func _process(delta):
	var _piece 
	if dragging:
		adjust_snap_x()
	
	var _grow = 0.02 if mouse_over and not dragging else -0.02
	_grow *= delta * 100
	mixer_contents_scale = clamp(mixer_contents_scale + _grow, 0, mixer_contents_scale_max)
	
	update_content_preview()
	
	mixer_contents.scale = Vector2(mixer_contents_scale, mixer_contents_scale)
		
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
		mouse_over = false
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
	

func update_doll_pattern(p : GameData.DollPattern) -> bool:
	if pattern == GameData.DollPattern.NONE:
		pattern = p
		emit_light_puff_particles()
		return true
	return false
	

func update_doll_color(c : GameData.DollColor) -> bool:
	if color == GameData.DollColor.NONE:
		color = c
		emit_light_puff_particles()
		return true
	return false


func update_doll_head(h : GameData.DollHeadShape) -> bool:
	if head_shape == GameData.DollHeadShape.NONE:
		if h == GameData.DollHeadShape.BEAR:
			$SoulBearSound.play()
		elif h == GameData.DollHeadShape.KITTO:
			$SoulCatSound.play()
		elif h == GameData.DollHeadShape.FROG:
			$SoulFrogSound.play()
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


func update_doll_eyes_count() -> bool:
	var _max : int = GameData.possible_eye_counts[GameData.possible_eye_counts.size()-1]
	if eyes_count <= _max:
		emit_light_puff_particles()
		eyes_count += 1
		return true
	return false


func update_doll_material_stuffing_count() -> bool:
	var _max : int = GameData.possible_material_counts[GameData.possible_material_counts.size()-1]
	if material_stuffing_count <= _max:
		emit_light_puff_particles()
		material_stuffing_count += 1
		return true
	return false


func update_doll_material_skin_count() -> bool:
	var _max : int = GameData.possible_material_counts[GameData.possible_material_counts.size()-1]
	if material_skin_count <= _max:
		emit_light_puff_particles()
		material_skin_count += 1
		return true
	return false


func _on_area_2d_mouse_entered():
	mouse_over = true


func _on_area_2d_mouse_exited():
	mouse_over = false


func emit_puff_particles():
	$PuffSound.play()
	$ParticlesDarkPuff.emitting = true
	

func emit_light_puff_particles():
	$PuffSound.play()
	$ParticlesLightPuff.emitting = true


func reset_mix():
	color = GameData.DollColor.NONE
	pattern = GameData.DollPattern.NONE
	head_shape = GameData.DollHeadShape.NONE
	eyes = GameData.DollEyes.NONE
	eyes_count = 0


func update_content_preview():
	var has_anything := false
	
	if head_shape == GameData.DollHeadShape.NONE:
		$MixerContents/SpriteHead.hide()
	else:
		has_anything = true
		$MixerContents/SpriteHead.show()
		$MixerContents/SpriteHead.texture = GameData.doll_head_sprites[head_shape]
	
	if pattern == GameData.DollPattern.NONE:
		$MixerContents/SpritePattern.hide()
	else:
		has_anything = true
		$MixerContents/SpritePattern.show()
		$MixerContents/SpritePattern/Pattern.texture = GameData.doll_pattern_sprites[pattern]
	
	if color == GameData.DollColor.NONE:
		$MixerContents/SpriteColor.hide()
	else:
		has_anything = true
		$MixerContents/SpriteColor.show()
		$MixerContents/SpriteColor.modulate = GameData.doll_colors[color]
	
	if eyes == GameData.DollEyes.NONE:
		$MixerContents/SpriteEye.hide()
		$MixerContents/Label.hide()
	else:
		has_anything = true
		$MixerContents/SpriteEye.show()
		$MixerContents/Label.show()
		$MixerContents/Label.text = "x" + str(eyes_count)
		$MixerContents/SpriteEye.texture = GameData.doll_eye_sprites[eyes]
	
	if material_stuffing_count <= 0:
		$MixerContents/SpriteStuffing.hide()
		$MixerContents/LabelStuffing.hide()
	else:
		has_anything = true
		$MixerContents/SpriteStuffing.show()
		$MixerContents/LabelStuffing.show()
		if material_stuffing_count > 1:
			$MixerContents/LabelStuffing.text = "x" + str(material_stuffing_count)
	
	if material_skin_count <= 0:
		$MixerContents/SpriteSkin.hide()
		$MixerContents/LabelSkin.show()
	else:
		has_anything = true
		$MixerContents/SpriteSkin.show()
		$MixerContents/LabelSkin.show()
		if material_skin_count > 1:
			$MixerContents/LabelSkin.text = "x" + str(material_skin_count)
	
	if !has_anything:
		mixer_contents_scale = 0

func _on_mixer_contents_effect_timer_timeout():
	for el in $MixerContents.get_children():
		el.rotation = randf_range(-1,1) * PI/16
