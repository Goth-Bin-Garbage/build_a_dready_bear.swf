extends Node2D

@onready var mouse_on : bool = false
@export var limb_type : GameData.DollLimbs = GameData.DollLimbs.PAW
@export var sprite_path : String = ""

var limb_piece = preload("res://stations/station_elements/LimbPieces.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = load(sprite_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mouse_on:
		if Input.is_action_just_pressed("left_mouse_click"):
			var new_limb = limb_piece.instantiate()
			new_limb.limb_type = limb_type
			get_tree().add_child(new_limb)

func _on_area_2d_mouse_entered():
	mouse_on = true

func _on_area_2d_mouse_exited():
	mouse_on = false
