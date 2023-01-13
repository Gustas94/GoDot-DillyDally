extends Node

func _ready():
	get_node("MainMenu/MarginContainer/VBox/New Game").connect("pressed", self, "on_new_game_pressed")
	get_node("MainMenu/MarginContainer/VBox/Quit").connect("pressed", self, "on_Quit_pressed")
	get_node("MainMenu/MarginContainer/VBox/About").connect("pressed", self, "on_About_pressed")
	get_node("MainMenu/MarginContainer/VBox/Settings").connect("pressed", self, "on_Settings_pressed")
	
func on_new_game_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://Scenes/MainScenes/GameScene.tscn").instance()
	add_child(game_scene)

func on_About_pressed():
	pass
	


func on_Quit_pressed():
	get_tree().quit()
