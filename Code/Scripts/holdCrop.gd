extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!global.has_crop):
		global.has_crop = false
		self.queue_free()
