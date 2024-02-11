extends Area2D
var MoveSpeed = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(self.position.x, self.position.y)
	self.position = self.position.move_toward(Vector2(0,0), delta * MoveSpeed)
