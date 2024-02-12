extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if(Input.is_action_just_pressed("ActionAttack")):
		ShootSpell()
#Define all Spells
@export var SPELLBOLT: PackedScene = preload("res://Scenes/Bolt.tscn")

func ShootSpell():
	print("Fire")
	#Change to shoot different spells
	if SPELLBOLT:
		var spell = SPELLBOLT.instantiate()
		get_tree().current_scene.add_child(spell)
		spell.global_position = get_owner().global_position
		spell.scale = Vector2(1, 1)
		
		var spellRotation = get_owner().global_position.direction_to(get_owner().get_global_mouse_position()).angle()
		spell.rotation = spellRotation
