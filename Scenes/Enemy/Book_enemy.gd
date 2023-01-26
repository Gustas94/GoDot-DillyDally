extends PathFollow2D

#Variable speed and HP
var speed = EnemyData.enemy_data["Book"]["speed"]
var hp = EnemyData.enemy_data["Book"]["hp"]
var money
var basehp = 100

#Function for offset
func _physics_process(delta):
	offset += speed * delta
	
	if unit_offset >= 1:
		reached_end()
		basehp -= 1


#if basehp <= 1:
#	func game_over()




#enemy gets killed
#if hp = 0:
#	func enemy_dies()



func enemy_dies():
	queue_free()
	money += 5


#Reaching the end
func reached_end():
	queue_free()
