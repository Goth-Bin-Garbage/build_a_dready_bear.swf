extends Node2D

# how many mixers can be placed along the bottom of the screen
@onready var mixer_positions : int = 6
@onready var offset_from_bottom : int = 50
@onready var snap_weight : float = 0.15

@onready var mouse_over : bool = false
@onready var dragging : bool = false

@onready var snap_x : int
@onready var old_snap_x : int


func _ready():
	adjust_snap_x()


func _process(delta):
	if dragging:
		adjust_snap_x()
	
	if Input.is_action_just_released("click"):
		if !dragging and mouse_over:
			old_snap_x = snap_x
			dragging = true
		elif dragging:
			for other_mixer in get_parent().get_children():
				if other_mixer != self and other_mixer.snap_x == snap_x:
					snap_x = old_snap_x
					break
			dragging = false
	
	if dragging:
		global_position = get_viewport().get_mouse_position()
	else: # snap to positions along bottom of screen
		global_position = lerp(
			global_position,
			Vector2(snap_x, Global.window_size.y - offset_from_bottom),
			snap_weight
		)


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
