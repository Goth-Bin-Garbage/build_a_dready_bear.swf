extends Node

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
