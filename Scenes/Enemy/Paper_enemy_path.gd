extends PathFollow2D

#Variable speed and HP
var speed = EnemyData.enemy_data["Paper"]["speed"]
var hp = EnemyData.enemy_data["Paper"]["hp"]
var money
var basehp = 100

#Function for offset
func _physics_process(delta):
	offset += speed * delta
	
	if unit_offset >= 1:
		reached_end()
	#	baseHP -= 1


#if basehp <= 1:
#	func game_over()




func _enemy_gets_killed():
	if hp == 0:
		enemy_dies()



func enemy_dies():
	queue_free()
	money += 5


#Reaching the end
func reached_end():
	queue_free()




