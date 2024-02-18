extends Node2D
var screen_size
@export var number = 10
@export var cooldown = 0.5
@onready var rng = RandomNumberGenerator.new()

@export var explosion: PackedScene = preload("res://Scenes/aoe_timer.tscn")
@export var ball: PackedScene = preload("res://Scenes/artillery.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	fire()

func fire():
	for i in range(number):		
		$AnimatedSprite2D.animation = "Launch"
		$AnimatedSprite2D.play()
		var location = Vector2(rng.randf_range(0, screen_size.x), rng.randf_range(0, screen_size.y))
		var currentExp = explosion.instantiate()
		var currentBall = ball.instantiate()
		get_tree().current_scene.add_child.call_deferred(currentExp)
		get_tree().current_scene.add_child.call_deferred(currentBall)
		currentExp.position= location
		currentBall.position  = self.position
		var dmg = rng.randf_range(50, 200)
		var size = (250 - dmg)/200
		var dist = manhattanDist(self.position, location)
		var duration = clamp(dist/110,2, 4)
		currentExp.initialize(duration, size, dmg)
		currentBall.initialize(location, duration)
		currentBall.scale = Vector2(size/6, size/6)
		await get_tree().create_timer(cooldown).timeout
	$AnimatedSprite2D.animation = "Idle"
	$AnimatedSprite2D.play()
	var destroy = create_tween()
	destroy.tween_property($AnimatedSprite2D, "modulate", Color(0, 0 , 0, 0), 1)
	destroy.tween_callback(self.queue_free)
func manhattanDist(pos1, pos2):
	return abs((pos1.x-pos2.x)+(pos1.y - pos2.y))
		
