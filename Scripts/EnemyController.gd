extends Node2D


signal enemy_base_destroyed 

var moveSpeed = 50
var speedModifier = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(self.position.x, self.position.y)
	var processedMoveSpeed = moveSpeed * speedModifier
	self.position = self.position.move_toward(Vector2(0,0), delta * processedMoveSpeed)

func Delete():
	queue_free()

func _on_status_status_destroyed():
	print("enemy killed")
	Delete()
	emit_signal("enemy_base_destroyed")


func _on_status_status_slow():
	speedModifier *= StatusEffectProperties.slowSpeedModifier
