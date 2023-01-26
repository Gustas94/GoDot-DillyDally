extends PathFollow2D

#Variable speed and HP
var speed = 100
var hp = 50

#Function for offset
func _physics_process(delta):
	offset += speed * delta
	
	if unit_offset >= 1:
		reached_end()
		
func on_hit(damage):
	hp -= damage
	if hp <= 0:
		on_destroy()
		
func on_destroy():
	self.queue_free()
	
#Reaching the end
func reached_end():
	queue_free()
	
	
