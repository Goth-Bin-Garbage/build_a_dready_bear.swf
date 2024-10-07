extends Node

# Game config stuff
# every <new_order_attempt_interval> seconds, the game has a
#  <new_order_attempt_chance> of giving the player a new order
var new_order_attempt_interval := 5.0 # seconds
var new_order_attempt_chance := 0.25

var order_life_time := 60.0 * 2 # 2 minutes

var number_orders_first_day := 3
var number_orders_second_day := 6

var possible_eye_counts := [1,2,3]
var possible_material_counts := [1,2]

# References to stuff
enum Station {FABRIC, HEAD, EYES, BODY, LIMBS, MIX}
var stations_dir = "res://stations/"
var station_scene_ids : Dictionary = {
	Station.FABRIC : stations_dir + "FabricStation.tscn",
	Station.HEAD : stations_dir + "HeadStation.tscn",
	Station.EYES : stations_dir + "EyeStation.tscn",
	Station.BODY : stations_dir + "BodyStation.tscn",
	Station.LIMBS : stations_dir + "LimbStation.tscn",
	Station.MIX : stations_dir + "MixStation.tscn"
}

enum DollColor {NONE, RED, BLUE, GREEN}
enum DollPattern {NONE, STRIPE, GRID, POLKA}
enum DollHeadShape {NONE, BEAR, KITTO, FROG}
enum DollEyes {NONE, EYEZALEA, BUTTONS}
enum DollLimbs {NONE, PAW, STRIPED, FLIPPER, WINGS}

var doll_colors : Dictionary = {
	DollColor.RED : Color.RED,
	DollColor.BLUE : Color.BLUE,
	DollColor.GREEN : Color.GREEN
}
# similar for, e.g., pattern, headshape... maybe return sprites?
