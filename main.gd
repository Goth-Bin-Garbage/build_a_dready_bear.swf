extends Node2D

@onready var loaded_station_id : String

@onready var station_node : Node2D = $Station
@onready var station_instance : Node2D

@onready var orders : Array = []

@onready var ui_node := $UI
@onready var ui_orders_node := $UI/Orders

var orders_received := 0


func _ready():
	load_station(Global.get_station_scene_file(GameData.Station.FABRIC))


func _process(delta):
	# DEBUG
	if Input.is_action_just_pressed("debug_new_order"):
		new_order()


func unload_station() -> void:
	if station_instance != null:
		station_instance.queue_free()


func load_station(station_id : String) -> void:
	if station_id == loaded_station_id:
		return
	unload_station()
	var new_station = load(station_id)
	station_instance = new_station.instantiate()
	station_node.add_child(station_instance)
	loaded_station_id = station_id


func change_station(new_station : GameData.Station) -> void:
	# find out if new station is to the left or right of current station
	var new_station_before_current = false
	var found_current_station = false
	for station in GameData.station_scene_ids.keys():
		if GameData.station_scene_ids[station] == loaded_station_id:
			found_current_station = true
		elif station == new_station:
			if !found_current_station:
				new_station_before_current = true
			load_station(GameData.station_scene_ids[station])
			break
	print("left" if new_station_before_current else "right")


var order_scene := preload("res://ui/order.tscn")

func new_order() -> void:
	# block creating new order if there are too many
	if self.orders.size() >= get_maximum_number_of_orders():
		return
	var order_instance = order_scene.instantiate()
	order_instance.name = "order_" + str(orders_received)
	ui_orders_node.add_child(order_instance)
	orders.append(order_instance)
	orders_received += 1


func get_maximum_number_of_orders() -> int:
	# only 2 maximum orders for the tutorial
	if Global.day == 0:
		return 2
	return 4
