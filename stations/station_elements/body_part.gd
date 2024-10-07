extends Node2D

var plucked : bool = false
var mouse_on : bool = false
var clicked_on : bool = false
var clickable : bool = true

var offset : Vector2
var material_type : GameData.DollMaterials

var acceleration_y := 0.0
var velocity_y := 0.0

var dragging := false

func _ready():
	pass

func _process(delta):
	if !dragging:
		acceleration_y = 0.03
		velocity_y += acceleration_y
		
		self.position.y += velocity_y
		
		if self.position.y >= 600:
			queue_free()
	else:
		global_position = get_viewport().get_mouse_position()
		
		if Input.is_action_just_released("left_mouse_click"):
			dragging = false
			Global.dragging_something = false


func insert_into_mixer(mixer) -> void:
	var successful_insert : bool
	if material_type == GameData.DollMaterials.STUFFING:
		successful_insert = mixer.update_doll_material_stuffing_count()
	elif material_type == GameData.DollMaterials.SKIN:
		successful_insert = mixer.update_doll_material_skin_count()
	if successful_insert:
		queue_free()
