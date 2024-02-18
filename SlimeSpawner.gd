extends Node2D
var cooldown = 5
var rng = RandomNumberGenerator.new()

@export var slime: PackedScene = preload("res://Scenes/Slime.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	spawnon()

func spawnoff():
	cooldown = rng.randi_range(3,8)
	await get_tree().create_timer(cooldown).timeout
	spawnon()
func spawnon():
	var currentslime = slime.instantiate()
	get_tree().current_scene.add_child.call_deferred(currentslime)
	currentslime.position = self.position
	spawnoff()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
