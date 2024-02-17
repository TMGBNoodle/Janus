extends Area2D

@onready var sprite : Sprite2D = get_node("DamageZone") 

# Called when the node enters the scene tree for the first time.
func _ready():
	doExplosion(5)
	
func doExplosion(duration):
	var explode = create_tween()
	explode.tween_property(sprite, "modulate", Color(0.8, 0, 0.1, 0.7), duration)
	explode.play()
	print("Hi")
	print(self.get_overlapping_bodies())
	for entity in self.get_overlapping_bodies():
		print("Entity Hit")
	explode.tween_callback(self.queue_free)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
