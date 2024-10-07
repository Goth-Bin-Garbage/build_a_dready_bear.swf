extends Node2D

@export var sprite_path : String = "res://sprites/eye_seed.png"
@export var eye_type : GameData.DollEyes = GameData.DollEyes.EYEZALEA

var parent_instance : Node2D

@onready var clickable : bool = false
@onready var mouse_on : bool = false
@export var plucked : bool = false
@onready var clicked_on : bool = false
var offset : Vector2

var acceleration_y := 0.0
var velocity_y := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if clickable:
		$Sprite2D.texture = GameData.doll_eye_sprites[eye_type]
		$Sprite2D.scale = Vector2(0.1, 0.1)
		z_index = 999
	else:
		return
		
	if self.position.y >= 600:
		queue_free()
	if plucked && !clicked_on:
		acceleration_y = 0.03
	velocity_y += acceleration_y
	
	self.position.y += velocity_y
	
	if Input.is_action_just_pressed("left_mouse_click") and mouse_on:
		offset = get_global_mouse_position() - global_position
		Global.dragging_something = true
		plucked = true
		
	if Input.is_action_pressed("left_mouse_click") and mouse_on:
		global_position = get_global_mouse_position() - offset
		clicked_on = true
	
	if Input.is_action_just_released("left_mouse_click"):
		Global.dragging_something = false
		clicked_on = false


func _on_area_2d_mouse_entered():
	mouse_on = true


func _on_area_2d_mouse_exited():
	mouse_on = false


func insert_into_mixer(mixer) -> void:
	var successful_insert : bool
	successful_insert = mixer.update_doll_eyes(eye_type) || mixer.update_doll_eyes_count(eye_type)
	if successful_insert:
		parent_instance.queue_free()
		queue_free()
