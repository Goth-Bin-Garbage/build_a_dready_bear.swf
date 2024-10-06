extends Node2D

@onready var clickable_eye : Node2D = $Eyes
@onready var plant_sprite : Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	clickable_eye.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	clickable_eye.visible = true
