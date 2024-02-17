extends Node2D
var screen_size
@export var number = 0
@onready var rng = RandomNumberGenerator.new()

@export var explosion: PackedScene = preload("res://Scenes/aoe_timer.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
	for i in range(number):
		var location = Vector2(rng.randf_range(0, screen_size), rng.randf_range(0, screen_size))
		var current = explosion.instantiate()
		
