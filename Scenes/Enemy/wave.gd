extends Node2D

var instance
var mob = load ("res://Scenes/Enemy/Empty_enemy.tscn")
var mob_list = [
	load ("res://Scenes/Enemy/Paper_enemy.tscn"),
	load ("res://Scenes/Enemy/Book_enemy.tscn")
]


#variables for the waves
var wave = 0
var wave_mobs = 5
var mobs_left = 0
var max_wave = 6

func _ready():
	_when_wave_is_done()

func _when_wave_is_done():
	if wave < max_wave:
		$WaveTimer.start()
	else:
		$WaveTimer.stop()


func _on_WaveTimer_timeout():
	mobs_left = wave_mobs
	$MobTimer.start()


func _on_MobTimer_timeout():
	if wave < 3:
		var enemy_spawn = rand_range(0, mob_list.size()-1)
		instance = mob_list[enemy_spawn].instance()
		$Path2D.add_child(instance)
	if wave >= 3:
		var enemy_spawn = rand_range(0, mob_list.size())
		instance = mob_list[enemy_spawn].instance()
		$Path2D.add_child(instance)
	mobs_left-= 1
	if mobs_left <= 0:
		$MobTimer.stop()
		wave += 1
		wave_mobs += 5
		return _when_wave_is_done()

