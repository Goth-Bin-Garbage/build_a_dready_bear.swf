
extends Node2D

@onready var spawns : Array = $PositionMarkers.get_children()
@onready var balls : Array = $FabricBalls.get_children()


# Called when the node enters the scene tree for the first time.
func _ready():
	for r in range(0,8):
		balls[r].position = spawns[r].position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if balls.count() != 8:
		regen_fabric()

func regen_fabric():
	for r in range(0,8):
		
