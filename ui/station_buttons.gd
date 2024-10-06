extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pluck_balls_button_pressed():
	Global.main.change_station(GameData.Station.FABRIC)


func _on_headshape_button_pressed():
	Global.main.change_station(GameData.Station.HEAD)


func _on_grow_eyes_button_pressed():
	Global.main.change_station(GameData.Station.EYES)


func _on_cut_body_button_pressed():
	Global.main.change_station(GameData.Station.BODY)


func _on_fill_limbs_button_pressed():
	Global.main.change_station(GameData.Station.LIMBS)


func _on_shake_button_pressed():
	Global.main.change_station(GameData.Station.MIX)
