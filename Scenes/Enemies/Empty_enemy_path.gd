extends PathFollow2D

#Variable speed and HP
var speed = 100
var hp = 10

#Function for offset
func _physics_process(delta):
	offset += speed * delta
	
	if unit_offset >= 1:
		reached_end()


#if hp <= 0:
#	reached_end()
	
#Reaching the end
func reached_end():
	queue_free()
