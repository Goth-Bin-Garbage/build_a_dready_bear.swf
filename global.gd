extends Node

@onready var main : Node2D = get_tree().get_root().get_node("Main")

@onready var dragging_something : bool = false
# game stuff
func get_doll_color(doll_color : GameData.DollColor) -> Color:
	return GameData.doll_colors[doll_color]

# get random doll features...
func get_random_doll_color() -> GameData.DollColor:
	return GameData.DollColor.values().pick_random()

func get_random_doll_pattern() -> GameData.DollPattern:
	return GameData.DollPattern.values().pick_random()

func get_random_doll_headshape() -> GameData.DollHeadShape:
	return GameData.DollHeadShape.values().pick_random()

func get_random_doll_eyes() -> GameData.DollEyes:
	return GameData.DollEyes.values().pick_random()
	
func get_station_scene_file(station : GameData.Station) -> String:
	return GameData.station_scene_ids[station]

# window management stuff (as done for LD55)
@onready var window_size: Vector2 = get_window().size
var window_scale: int = 1
const max_scale: int = 4
var is_fullscreen: bool = false

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
	if event.is_action_pressed("window_size"):
		if window_scale < max_scale:
			window_scale = window_scale + 1
		else:
			window_scale = 1
		get_window().size = window_size * window_scale
	if event.is_action_pressed("fullscreen"):
		if is_fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			is_fullscreen = false
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			is_fullscreen = true
