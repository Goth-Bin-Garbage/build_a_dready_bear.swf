
extends Node2D

@onready var spawns : Array = $PositionMarkers.get_children()
@onready var balls : Array = $FabricBalls.get_children()


# Called when the node enters the scene tree for the first time.
func _ready():
	for r in range(0,6):
		balls[r].position = spawns[r].position
		balls[r].home_pos = spawns[r].position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
