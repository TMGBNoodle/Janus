extends Area2D
var moveSpeed = 20

var speedModifier = 0
var slowEffectPercentage = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(self.position.x, self.position.y)
	var processedMoveSpeed = moveSpeed * slowEffectPercentage
	self.position = self.position.move_toward(Vector2(0,0), delta * processedMoveSpeed)
