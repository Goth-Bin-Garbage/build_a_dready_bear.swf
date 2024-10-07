extends Node2D

@onready var clickable_eye : Node2D = $Eyes
@onready var plant_sprite : Sprite2D = $Sprite2D

@export var plant_type : GameData.DollEyes = GameData.DollEyes.EYEZALEA

@onready var plant_wait_time : float = $Timer.wait_time

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	
	if plant_type == GameData.DollEyes.EYEZALEA:
		clickable_eye.sprite_path = "res://sprites/eye_seed.png"
	if plant_type == GameData.DollEyes.BUTTONS:
		clickable_eye.sprite_path = "res://sprites/button_seed.png"
	clickable_eye.eye_type = plant_type
	
	clickable_eye.parent_instance = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time_spent = plant_wait_time - $Timer.time_left
	var time_fraction = time_spent / plant_wait_time
	
	Global.plant_wait_times[self.name] = $Timer.wait_time
	clickable_eye.rotation = ((PI / 2) - ((PI / 2) * time_fraction))
	
	if clickable_eye.global_position.y > 680:
		self.queue_free()

func _on_timer_timeout():
	plant_sprite.frame = 3
	clickable_eye.visible = true
	clickable_eye.clickable = true
