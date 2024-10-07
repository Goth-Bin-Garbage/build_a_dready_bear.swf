extends Node2D


func _ready():
	$OrderTimer.wait_time = GameData.new_order_attempt_interval


func _on_timer_timeout():
	if randf() <= GameData.new_order_attempt_chance:
		Global.main.new_order()
	$OrderTimer.start()


func _on_day_end_timer_timeout():
	Global.main.return_to_day_screen()
