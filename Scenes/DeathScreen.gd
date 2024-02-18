extends MarginContainer

var doorTexture1 = preload("res://TheDoor/Sprites/TheDoor.png")
var doorTexture2 = preload("res://TheDoor/Sprites/TheDoor2.png")

var returnButtonDoorTexture
var pointTotalDisplay
# Called when the node enters the scene tree for the first time.
func _ready():
	returnButtonDoorTexture = get_node("VBox").get_node("HBoxContainer").get_node("ReturnDoor")
	pointTotalDisplay = get_node("VBox").get_node("Points")
	
	#pointTotalDisplay.clear()
	pointTotalDisplay.text = "[center]"+ str(GameData.GetPointTotal()) + "[/center]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func AddScene(simultaneousScene):
	# This is like autoloading the scene, only
	# it happens after already loading the main scene.
	get_tree().root.add_child(simultaneousScene)


func _on_return_button_pressed():
	#var simultaneousScene = preload("res://Scenes/TitleScreen.tscn").instantiate()
	#AddScene(simultaneousScene)
	#if get_node("/root/WorldNode"):
		#get_node("/root/WorldNode").queue_free()
	#if get_node("/root/DeathScreen"):
		#get_node("/root/DeathScreen").queue_free()
	get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")
	


func _on_return_button_mouse_entered():
	returnButtonDoorTexture.texture = doorTexture1


func _on_return_button_mouse_exited():
	returnButtonDoorTexture.texture = doorTexture2
