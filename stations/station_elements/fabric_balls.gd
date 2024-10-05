extends Node2D

@export var plucked : bool = false
@onready var mouse_on : bool = false
@onready var clicked_on : bool = false

var offset : Vector2
@export var home_pos : Vector2
@export var fabric_type

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_fabric()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if plucked && !clicked_on:
		self.position.y += 0.1
		
		if self.position.y >= 450:
			regen_fabric()
		
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

func generate_fabric():
	

func regen_fabric():
	pass
