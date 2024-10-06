extends Node

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
enum DollEyes {EZEYALEA, BUTTONS}

var doll_colors : Dictionary = {
	DollColor.RED : Color.RED,
	DollColor.BLUE : Color.BLUE,
	DollColor.GREEN : Color.GREEN
}
# similar for, e.g., pattern, headshape... maybe return sprites?
