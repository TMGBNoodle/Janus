extends Node2D

@export var THEDOOR: PackedScene = preload("res://TheDoor/TheDoor.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("TestButton")):
		SummonDoor()

func SummonDoor():
	var theDoor = THEDOOR.instantiate()
	get_tree().current_scene.add_child(theDoor)
	theDoor.global_position = self.global_position + Vector2(400,400)
