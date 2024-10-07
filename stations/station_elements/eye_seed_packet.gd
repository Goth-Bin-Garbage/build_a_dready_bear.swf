extends Node2D

@onready var mouse_on : bool = false
@export var sprite_path : String = ""
@export var eye_type : GameData.DollEyes = GameData.DollEyes.EYEZALEA
@onready var home_pos : Vector2
var offset : Vector2

var eye_plant_scene := preload("res://stations/station_elements/EyePlants.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = load(sprite_path)
	home_pos = self.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("left_mouse_click"):
		offset = get_global_mouse_position() - global_position
		self.rotate(PI / 4)
		
		if Input.is_action_pressed("left_mouse_click"):
			global_position = get_global_mouse_position() - offset
		
		elif Input.is_action_just_released("left_mouse_click"):
			var tween = get_tree().create_tween()
			self.rotate(0)
			tween.tween_property(self, "global_position",home_pos,0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_mouse_entered():
	mouse_on = true

func _on_area_2d_mouse_exited():
	mouse_on = false


func _on_drop_collision_area_entered(area):
	var eye_plant_instance := eye_plant_scene.instantiate()
	eye_plant_instance.plant_type = eye_type
	get_parent().get_parent().get_node("Plants").add_child(eye_plant_instance)
