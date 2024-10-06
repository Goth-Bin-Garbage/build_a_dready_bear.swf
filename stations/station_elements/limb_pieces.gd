extends Node2D

@onready var mouse_on : bool = false
@onready var locked : bool = false
@export var filled : float = 0
var offset : Vector2

@export var limb_type : GameData.DollLimbs = GameData.DollLimbs.PAW


# Called when the node enters the scene tree for the first time.
func _ready():
	match limb_type:
		GameData.DollLimbs.PAW:
			$Sprite2D.texture = load("")
		GameData.DollLimbs.STRIPED:
			$Sprite2D.texture = load("")
		GameData.DollLimbs.FLIPPER:
			$Sprite2D.texture = load("")
		GameData.DollLimbs.WINGS:
			$Sprite2D.texture = load("")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mouse_on:
		if Input.is_action_just_pressed("left_mouse_click"):
			offset = get_global_mouse_position() - global_position
		
		if Input.is_action_pressed("left_mouse_click"):
			global_position = get_global_mouse_position() - offset
		
		elif Input.is_action_just_released("left_mouse_click"):
			pass


func _on_area_2d_mouse_entered():
	mouse_on = true

func _on_area_2d_mouse_exited():
	mouse_on = false
