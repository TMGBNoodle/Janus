extends Node2D


signal enemy_base_destroyed 

var moveSpeed = 50
var speedModifier = 1

var isSlowed: bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	#print(self.position.x, self.position.y)
	if isSlowed:
		get_parent().isSlowed = true
	#self.position = self.position.move_toward(Vector2(0,0), delta * processedMoveSpeed)
  
func Delete():
	var destroy = create_tween()
	destroy.tween_property($AnimatedSprite2D, "modulate", Color(0, 0 , 0, 0), 1)
	destroy.tween_callback(self.queue_free)

func _on_status_status_destroyed():
	print("enemy killed")
	emit_signal("enemy_base_destroyed")
	Delete()
	


func _on_status_status_slow():
	isSlowed = true
	#speedModifier *= StatusEffectProperties.slowSpeedModifier

