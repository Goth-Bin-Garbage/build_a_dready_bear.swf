extends Node2D

@export var plucked : bool = false
@onready var mouse_on : bool = false
@onready var clicked_on : bool = false
@onready var clickable : bool = true

var offset : Vector2
@export var home_pos : Vector2
@export var fabric_type : String = "Color"
@export var color : GameData.DollColor = GameData.DollColor.RED
@export var pattern : GameData.DollPattern = GameData.DollPattern.STRIPE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if plucked && !clicked_on:
		self.position.y += 0.1
		
		if self.position.y >= 500:
			regen_fabric()
	
	if mouse_on && clickable:
		if Input.is_action_just_pressed("left_mouse_click") && !Global.dragging_something:
			Global.dragging_something = true
			offset = get_global_mouse_position() - global_position
			plucked = true
		
		if Input.is_action_pressed("left_mouse_click") and plucked:
			global_position = get_global_mouse_position() - offset
			clicked_on = true
		
		elif Input.is_action_just_released("left_mouse_click"):
			Global.dragging_something = false
			clicked_on = false
	
	if !clickable:
		if self.scale != Vector2(1.0,1.0):
			var time_spent = 8 - $Timer.time_left
			var time_fraction = time_spent / 8.0
			self.scale = Vector2(time_fraction, time_fraction)

func _on_area_2d_mouse_entered():
	mouse_on = true

func _on_area_2d_mouse_exited():
	mouse_on = false

func regen_fabric():
	position = home_pos
	self.scale = Vector2(0,0)
	plucked = false
	clickable = false
	$Timer.start()

func _on_timer_timeout():
	clickable = true


func insert_into_mixer(mixer) -> void:
	var successful_insert : bool = mixer.update_doll_color_pattern(color, pattern)
	if successful_insert:
		Global.dragging_something = false
		regen_fabric()
