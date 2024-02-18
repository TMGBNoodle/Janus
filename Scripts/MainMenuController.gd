extends MarginContainer

var doorTexture1 = preload("res://TheDoor/Sprites/TheDoor.png")
var doorTexture2 = preload("res://TheDoor/Sprites/TheDoor2.png")

var startButtonDoorTexture
# Called when the node enters the scene tree for the first time.
func _ready():
	startButtonDoorTexture = get_node("MenuLayout").get_node("Doors").get_node("StartButtonDoorTexture")
	if get_node("/root/WorldNode"):
		get_node("/root/WorldNode").queue_free()
	if get_node("/root/DeathScreen"):
		get_node("/root/DeathScreen").queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	#var simultaneousScene = preload("res://Scenes/Main.tscn").instantiate()
	#AddScene(simultaneousScene)
	get_tree().change_scene_to_file	("res://Scenes/Main.tscn")
	#get_node("/root/MainMenu").queue_free()
	

func AddScene(simultaneousScene):
	# This is like autoloading the scene, only
	# it happens after already loading the main scene.
	get_tree().root.add_child(simultaneousScene)


func _on_start_button_mouse_exited():
	startButtonDoorTexture.texture = doorTexture1


func _on_start_button_mouse_entered():
	startButtonDoorTexture.texture = doorTexture2
