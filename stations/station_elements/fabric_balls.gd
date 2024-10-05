extends Node2D

@onready var plucked : bool = false
@onready var mouse_on : bool = false
@onready var clicked_on : bool = false
var offset : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("Mouse On: ", mouse_on)
	print("Plucked: ", plucked)
	if plucked && !clicked_on:
		self.position.y += 0.1
		
	if mouse_on:
		if Input.is_action_just_pressed("left_mouse_click"):
			offset = get_global_mouse_position() - global_position
			plucked = true
		
		if Input.is_action_pressed("left_mouse_click"):
			global_position = get_global_mouse_position() - offset
			clicked_on = true
		
		elif Input.is_action_just_released("left_mouse_click"):
			clicked_on = false

func _on_area_2d_mouse_entered():
	mouse_on = true

func _on_area_2d_mouse_exited():
	mouse_on = false
