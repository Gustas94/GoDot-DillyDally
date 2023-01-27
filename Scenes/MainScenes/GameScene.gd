extends Node2D

var map_node

var build_mode = false
var Money = 150
var build_valid = false
var build_location
var build_type
var current_wave = 0
var enemies_in_wave = 0
##
## seclection functions
##
func _ready():
	map_node = get_node("Map1")
	for index in get_tree().get_nodes_in_group("build_buttons"):
		index.connect("pressed", self, "initiate_build_mode", [index.get_name()])
	$UserInterface/HUD/Money_counter.text = str("Cash: ", Money)


func _process(_delta):
	if build_mode:
		update_tower_preview()


func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()

##
## Wave functions
##


##
## build functions
##
func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = tower_type + "T1"
	build_mode = true
	get_node("UserInterface").set_tower_preview(build_type, get_global_mouse_position())


func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExculusion").world_to_map(mouse_position)
	
	if map_node.get_node("TowerExculusion").get_cellv(current_tile):
		get_node("UserInterface").update_tower_preview(mouse_position, "ad54ff3c")
		build_valid = true
		build_location = mouse_position
	else:
		get_node("UserInterface").update_tower_preview(mouse_position, "adff4545")
		build_valid = false


func cancel_build_mode():
	build_mode = false
	build_valid = false
	get_node("UserInterface/TowerPreview").free()


func verify_and_build():
	if build_valid:
		## test to see if player has enough money
		var Price = GameData.tower_data[build_type]["Price"]
		if Money >= Price:
			var new_tower = load("res://Scenes/Towers/" + build_type + ".tscn").instance()
			new_tower.position = build_location
			new_tower.type = build_type
			map_node.get_node("Towers").add_child(new_tower, true)
			## deduct cash
			Money -= Price
			## update cash lable
	$UserInterface/HUD/Money_counter.text = str("Cash: ", Money)
