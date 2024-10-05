extends Node2D

@onready var loaded_station_id : String

@onready var station_node : Node2D = $Station
@onready var station_instance : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	load_station("FabricStation")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func unload_station() -> void:
	if station_instance != null:
		station_instance.queue_free()


func load_station(station_id : String) -> void:
	if station_id == loaded_station_id:
		return
	unload_station()
	var new_station = load("res://stations/" + station_id + ".tscn")
	station_instance = new_station.instantiate()
	station_node.add_child(station_instance)
	loaded_station_id = station_id
