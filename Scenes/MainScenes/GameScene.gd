extends Node2D

var map_node

var build_mode = false
var build_valid = false
var build_location
var build_type
var current_wave = 0
var enemies_in_wave = 0
var Money = 150
##
## seclection functions
##
func _ready():
	map_node = get_node("Map1")
	for index in get_tree().get_nodes_in_group("build_buttons"):
		index.connect("pressed", self, "initiate_build_mode", [index.get_name()])
	start_next_wave()
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
## Wave functions (DELETED)
##
func start_next_wave():
	var wave_data = retrieve_wave_data()
	yield(get_tree().create_timer(0.2),"timeout")
	spawn_enemies(wave_data)
	
func retrieve_wave_data():
	var wave_data = [["Paper", 0.7], ["Paper", 0.1]]
	current_wave += 1
	enemies_in_wave = wave_data.size()
	return wave_data
		
func spawn_enemies(wave_data):
	for i in wave_data:
		var new_enemy = load("res://Scenes/Enemies/" + i[0] + ".tscn").instance()
		map_node.get_node("Path").add_child(new_enemy, true)
		yield(get_tree().create_timer(i[1]), "timeout")
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
			new_tower.built = true
			new_tower.type = build_type
			map_node.get_node("Towers").add_child(new_tower, true)
			Money -= Price
			print(Money)
			$UserInterface/HUD/Money_counter.text = str("Cash: ", Money)
		## deduct cash
		## update cash lable
