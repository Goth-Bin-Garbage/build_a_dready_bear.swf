extends Node2D

@onready var loaded_station_id : String
@onready var loaded_station : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	load_station("FabricStation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func unload_station() -> void:
	if loaded_station != null:
		loaded_station.queue_free()


func load_station(station_id : String) -> void:
	if station_id == loaded_station_id:
		return
	unload_station()
	var new_station = load("res://stations/" + station_id + ".tscn")
	loaded_station_id = station_id
