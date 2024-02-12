extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	doExplosion(3)

func doExplosion(duration):
	var explode = create_tween()
	explode.tween_property(self, "modulate", Color(0.8, 0, 0.1, 0.7), duration)
	explode.play()
	explode.tween_callback(self.queue_free)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
