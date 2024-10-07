extends Node2D


func _process(delta):
	$DayNumberLabel.text = "DAY " + str(Global.day + 1)


func _on_button_pressed():
	Global.main.start_day()
