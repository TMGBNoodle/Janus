extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var areas = get_overlapping_areas()
	print(areas)
		

func Destroy():
	queue_free()

func _on_area_entered(area):
	Destroy()


func _on_body_entered(body):
	Destroy()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
