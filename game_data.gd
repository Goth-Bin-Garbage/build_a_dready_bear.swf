extends Node

# Game config stuff
# every <new_order_attempt_interval> seconds, the game has a
#  <new_order_attempt_chance> of giving the player a new order
var new_order_attempt_interval := 5.0 # seconds
var new_order_attempt_chance := 0.25

var order_life_time := 60.0 * 2 # 2 minutes

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

# body stuff (based on colour)
enum DollColor {RED, BLUE, GREEN, YELLOW}
enum DollPattern {STRIPE, GRID, POLKA}
enum DollHeadShape {BEAR, KITTO, FROG, BAT, MOUSE}
enum DollEyes {EYEZALEA, BUTTONS}
enum DollLimbs {PAW, STRIPED, FLIPPER, WINGS}

var doll_colors : Dictionary = {
	DollColor.RED : Color.RED,
	DollColor.BLUE : Color.BLUE,
	DollColor.GREEN : Color.GREEN
}
# similar for, e.g., pattern, headshape... maybe return sprites?
