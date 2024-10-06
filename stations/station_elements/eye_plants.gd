extends Node2D

@onready var clickable_eye : Node2D = $Eyes
@onready var plant_sprite : AnimatedSprite2D = $AnimatedSprite2D

@onready var plant_type : GameData.DollEyes = GameData.DollEyes.EYEZALEA

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	clickable_eye.visible = false
	
	if plant_type == GameData.DollEyes.EYEZALEA:
		plant_sprite.play("Eyezalea")
	if plant_type == GameData.DollEyes.BUTTONS:
		plant_sprite.play("Buttonbud")
	
	plant_sprite.frame = 0
	plant_sprite.pause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time_spent = 20 - $Timer.time_left
	var time_fraction = time_spent / 20.0
	
	if time_fraction == (1/2):
		plant_sprite.frame = 1
	if time_fraction == (3/4):
		plant_sprite.frame = 2
	
	if clickable_eye.global_position.y <= 680:
		self.queue_free()

func _on_timer_timeout():
	plant_sprite.frame = 3
	clickable_eye.visible = true
