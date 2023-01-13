extends PathFollow2D


#variables for speed and HP
var speed = 1
var HP = 10

#func for moving
func _physics_process(delta):
	offset += speed + delta
	
	if unit_offset >= 1:
		reached_end()
		
func reached_end():
	queue_free()
	


