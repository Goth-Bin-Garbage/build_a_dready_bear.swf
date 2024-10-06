extends Node2D

@onready var mouse_on : bool = false
# 1 = small, 2 = med, 3 = big
@onready var size : int = 0

@onready var timer : Timer = $Timer
@onready var progress_window : Sprite2D = $ProgressWindow

var body_part = preload("res://stations/station_elements/BodyPart.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	progress_window.position = $ProgressRest.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mouse_on:
		var tween = get_tree().create_tween()
		if Input.is_action_just_pressed("left_mouse_click"):
			if size == 0:
				timer.start()
			tween.tween_property(progress_window, "position", $ProgressUp.position,0.2).set_ease(Tween.EASE_OUT)
		
		if Input.is_action_pressed("left_mouse_click"):
			pass
		
		elif Input.is_action_just_released("left_mouse_click"):
			timer.stop()
			tween.tween_property(progress_window, "global_position",$ProgressRest.position,0.2).set_ease(Tween.EASE_OUT)
			
			var new_body = body_part.instantiate()
			new_body.size = size
			self.add_child(new_body)
			new_body.position = $BodySpawn.position

func _on_area_2d_mouse_entered():
	mouse_on = true

func _on_area_2d_mouse_exited():
	mouse_on = false

func _on_timer_timeout():
	if size < 3:
		size += 1
		timer.start()
