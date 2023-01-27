extends PathFollow2D


var speed = 250
var hp = 150

func _physics_process(delta):
	move(delta)
	
func move(delta):
	set_offset(get_offset() + speed * delta)

func on_hit(damage):
	hp -= damage
	if hp <= 0:
		on_destroy()
		
func on_destroy():
	self.queue_free()