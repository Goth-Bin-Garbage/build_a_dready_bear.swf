extends Node2D

# do dials[i].head_type for their value
@onready var dials : Array = $Dials.get_children()
var selected_heads : Array = []

@onready var mouse_on_master : bool = false
@onready var clickable_master : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mouse_on_master && clickable_master:
		if Input.is_action_just_pressed("left_mouse_click"):
			clickable_master = false
			$MasterDial.rotate(PI / 2)
			$MasterDialTimer.start()
			# send selected_heads to mixer array

func _on_area_2d_mouse_entered():
	mouse_on_master = true

func _on_area_2d_mouse_exited():
	mouse_on_master = false

func _on_master_dial_timer_timeout():
	$MasterDial.rotation = 0.0
	clickable = true
