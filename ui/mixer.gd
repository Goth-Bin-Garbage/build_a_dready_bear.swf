extends Node2D

@onready var mixer_positions : int = 6

@onready var mouse_over : bool = false
@onready var dragging : bool = false

func _ready():
	pass # Replace with function body.


func _process(delta):
	if dragging:
		global_position = get_viewport().get_mouse_position()
	else: # snap to positions along bottom of screen
		var _w = 800 / mixer_positions
		var _x : int = clamp(round(global_position.x / _w) * _w, _w, 800 - _w)
		global_position = lerp(global_position, Vector2(_x, 600 - 50), .2)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if mouse_over:
			dragging = true
	else:
		dragging = false


func _on_area_2d_mouse_entered():
	mouse_over = true


func _on_area_2d_mouse_exited():
	mouse_over = false
