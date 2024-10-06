extends Node2D

@onready var mouse_on : bool = false
var offset : Vector2

@export var size : int = 0
@onready var sprite_path : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	size -= 1
	$Sprite2D.texture = load(sprite_path[size])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if !clicked_on:
	#	self.position.y += 0.1
	
	if mouse_on:
		if Input.is_action_just_pressed("left_mouse_click"):
			offset = get_global_mouse_position() - global_position
		
		if Input.is_action_pressed("left_mouse_click"):
			global_position = get_global_mouse_position() - offset
		
		elif Input.is_action_just_released("left_mouse_click"):
			pass
