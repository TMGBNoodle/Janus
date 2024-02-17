extends Area2D

@onready var sprite : Sprite2D = get_node("DamageZone") 
@onready var collision : CollisionShape2D = get_node("CollisionShape2D")
var damage = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	doExplosion(5, 5, 250)
	
func doExplosion(duration, size, ndamage):
	damage = ndamage
	sprite.scale = Vector2(size, size)
	collision.scale = Vector2(size, size)
	print(self.get_overlapping_areas())
	var explode = create_tween()
	explode.tween_property(sprite, "modulate", Color(0.8, 0, 0.1, 0.7), duration)
	explode.play()
	explode.tween_callback(doFinal)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func doFinal():
	var scene_tree = get_tree()
	await scene_tree.physics_frame
	for entity in self.get_overlapping_areas():
		print("Dealing " + str(damage) + " Damage to " + str(entity))
		var status = entity.get_node_or_null("Status")
		if status == null:
			status = entity.get_parent().get_node_or_null("Status")
		if status != null:
			status.Damage(damage)
	self.queue_free()
