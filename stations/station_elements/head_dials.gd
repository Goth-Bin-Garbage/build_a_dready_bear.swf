extends Node2D

@export var head_type : GameData.DollHeadShape = GameData.DollHeadShape.BEAR

@onready var mouse_on : bool = false
@onready var clickable : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mouse_on && clickable:
		if Input.is_action_just_pressed("left_mouse_click"):
			clickable = false
			self.rotate(PI / 2)
			$Timer.start()
			$ClickSound.play()
			# while(self.rotation_degrees <= 90.0):
				# self.rotation_degrees += 0.01
				# self.rotate(sign(PI / 2) * min(delta * 0.01, abs(PI / 2)))
				# this is supposed to be a visible rotation but i'm not getting it to work properly

func _on_area_2d_mouse_entered():
	mouse_on = true

func _on_area_2d_mouse_exited():
	mouse_on = false

func _on_timer_timeout():
	self.rotation = 0.0
	clickable = true
