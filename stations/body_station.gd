extends Node2D

var mouse_on_stuffing := false
var mouse_on_skin := false

@onready var timer : Timer = $Timer
@onready var progress_window : Sprite2D = $ProgressWindow

var body_part = preload("res://stations/station_elements/BodyPart.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("left_mouse_click") and (mouse_on_skin || mouse_on_stuffing):
		var _material_instance := body_part.instantiate()
		_material_instance.global_position = get_viewport().get_mouse_position()
		var _t : GameData.DollMaterials
		if mouse_on_skin:
			_t = GameData.DollMaterials.SKIN
		elif mouse_on_stuffing:
			_t = GameData.DollMaterials.STUFFING
		_material_instance.get_node("Sprite2D").texture = GameData.doll_material_sprites[_t]
		_material_instance.material_type = _t
		Global.dragging_something = true
		_material_instance.dragging = true
		$Materials.add_child(_material_instance)


func _on_area_skin_mouse_entered():
	mouse_on_skin = true


func _on_area_skin_mouse_exited():
	mouse_on_skin = false
	
	
func _on_area_stuffing_mouse_entered():
	mouse_on_stuffing = true


func _on_area_stuffing_mouse_exited():
	mouse_on_stuffing = false
