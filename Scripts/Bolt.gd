extends Area2D
var SpellSpeed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#var areas = get_overlapping_areas()
	#print(areas)
		
func _physics_process(delta):
	var Direction = Vector2.RIGHT.rotated(rotation)
	global_position += SpellSpeed *	Direction * delta

func Destroy():
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_hitbox_area_entered(area):
	Destroy()
