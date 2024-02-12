extends Node2D
var health = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Damage(damage):
	health -= damage
	if health <= 0:
		Destroy();

func Destroy():
	print("Destroyed")
	get_owner().Delete()

func _on_hurtbox_area_entered(hitbox):
	var baseDamage = hitbox.damage
	Damage(baseDamage)
	print("Enemy Hit new health", health)
