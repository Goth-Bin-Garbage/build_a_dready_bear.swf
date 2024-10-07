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

var acceleration_y := 0.0
var velocity_y := 0.0

var dragging := false

# Called when the node enters the scene tree for the first time.
func _ready():
	if fabric_type == "Color":
		$Sprite2D.modulate = GameData.doll_colors[color]
	if fabric_type == "Pattern":
		$Sprite2D/Pattern.visible = true
		match pattern:
			GameData.DollPattern.STRIPE:
				$Sprite2D/Pattern.texture = load("res://sprites/stripes.png")
			GameData.DollPattern.POLKA:
				$Sprite2D/Pattern.texture = load("res://sprites/polka.png")
			GameData.DollPattern.GRID:
				$Sprite2D/Pattern.texture = load("res://sprites/plaid.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if plucked && !clicked_on:
		acceleration_y = 0.03
		velocity_y += acceleration_y
		
		self.position.y += velocity_y
		
		if self.position.y >= 560:
			regen_fabric()
	
	if mouse_on && clickable:
		if Input.is_action_just_pressed("left_mouse_click") && !Global.dragging_something:
			Global.dragging_something = true
			offset = get_global_mouse_position() - global_position
			$ClickSound.play()
			plucked = true
			dragging = true
		
	if dragging:
		global_position = get_global_mouse_position() - offset
		clicked_on = true
		
	if Input.is_action_just_released("left_mouse_click"):
		Global.dragging_something = false
		dragging = false
		clicked_on = false
	
	if !clickable:
		if self.scale != Vector2(1.0,1.0):
			var time_spent = 8 - $Timer.time_left
			var time_fraction = time_spent / 8.0
			self.scale = Vector2(time_fraction, time_fraction)
			self.rotation += .01

func _on_area_2d_mouse_entered():
	mouse_on = true

func _on_area_2d_mouse_exited():
	mouse_on = false

func regen_fabric():
	velocity_y = 0
	acceleration_y = 0
	position = home_pos
	self.scale = Vector2(0,0)
	plucked = false
	clickable = false
	$Timer.start()

func _on_timer_timeout():
	clickable = true


func insert_into_mixer(mixer) -> void:
	var successful_insert : bool
	if fabric_type == "Pattern":
		successful_insert = mixer.update_doll_pattern(pattern)
	else:
		successful_insert = mixer.update_doll_color(color)
	if successful_insert:
		Global.dragging_something = false
		regen_fabric()
