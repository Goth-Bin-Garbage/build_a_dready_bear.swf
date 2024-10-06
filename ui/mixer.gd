extends Node2D

# how many mixers can be placed along the bottom of the screen
@onready var mixer_positions : int = 5
@onready var offset_from_bottom : int = 50
@onready var snap_weight : float = 0.15

@onready var mouse_over : bool = false
@onready var dragging : bool = false

@onready var previous_position : Vector2 = global_position

@onready var snap_x : int
@onready var old_snap_x : int

@onready var scale_normal : Vector2 = Vector2(1,1)
@onready var scale_dragging : Vector2 = Vector2(1.5, 1.5)

@onready var color : GameData.DollColor
@onready var pattern : GameData.DollPattern
@onready var head_shape : GameData.DollHeadShape
@onready var eyes : GameData.DollEyes

@onready var area : Area2D = $Area2D
@onready var hovering_over_order : Node2D


func _ready():
	adjust_snap_x()


func _process(delta):
	if dragging:
		adjust_snap_x()
		
	scale = lerp(scale, scale_normal if !dragging else scale_dragging, .15)
	
	if Global.dragging_something:
		var areas = area.get_overlapping_areas()
		hovering_over_order = null
		for a : Area2D in areas:
			if a.is_in_group("order"):
				var order = a.get_parent().get_parent()
				hovering_over_order = order
				break
		print(hovering_over_order)
		
	#if Input.is_action_just_released("click"):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if !dragging and mouse_over and !Global.dragging_something:
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


func _on_area_2d_mouse_entered():
	mouse_over = true


func _on_area_2d_mouse_exited():
	mouse_over = false


func emit_puff_particles():
	$CPUParticles2D.emitting = true
