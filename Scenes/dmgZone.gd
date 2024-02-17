extends Area2D

@onready var sprite : Sprite2D = get_node("DamageZone") 
@onready var collision : CollisionShape2D = get_node("CollisionShape2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	doExplosion(5, 0.5)
	
func doExplosion(duration, size):
	sprite.scale = Vector2(size, size)
	collision.scale = Vector2(0, 0)
	var explode = create_tween()
	
	explode.tween_property(sprite, "modulate", Color(0.8, 0, 0.1, 0.7), duration)
	explode.tween_property(collision, "scale", Vector2(size, size), duration)
	explode.play()
	var scene_tree = get_tree()
	await scene_tree.physics_frame
	for entity in self.get_overlapping_areas():
		print("Entity Hit")
	explode.tween_callback(self.queue_free)
# Called every frame. 'delta' is the elapsed time since the previous frame.
