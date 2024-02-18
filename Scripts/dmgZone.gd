extends Area2D

signal completed
@onready var sprite : Sprite2D
@onready var collision : CollisionShape2D
var damage
var size
var duration

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("completed")
func initialize(nduration, nsize, ndamage):
	damage = ndamage
	sprite = await get_node("DamageZone") 
	print(sprite)
	collision = await get_node("CollisionShape2D")
	size = nsize
	duration = nduration
	await completed
	doExplosion()
	
func doExplosion():
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
