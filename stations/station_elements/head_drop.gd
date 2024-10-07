extends Node2D

@export var plucked : bool = false
@onready var mouse_on : bool = false
@onready var clicked_on : bool = false
@onready var clickable : bool = true

var offset : Vector2
@export var head : GameData.DollHeadShape

var acceleration_y := 0.0
var velocity_y := 0.0

func _ready():
	pass

func _process(delta):
	acceleration_y = 0.03
	velocity_y += acceleration_y
	
	self.position.y += velocity_y
	
	if self.position.y >= 600:
		queue_free()


func insert_into_mixer(mixer) -> void:
	var successful_insert : bool
	successful_insert = mixer.update_doll_head(head)
	if successful_insert:
		queue_free()
