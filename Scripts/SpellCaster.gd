extends Node

var SpellOrigin

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

enum Spells 
{
	SPELLBOLT,
	ICEBOLT,
	BARRAGE
}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(_delta):
	if(Input.is_action_just_pressed("ActionAttack")):
		ShootSpell(Spells.ICEBOLT)
#Define all Spells
@export var SPELLBOLT: PackedScene = preload("res://Scenes/Bolt.tscn")
@export var ICESPELL: PackedScene = preload("res://Scenes/IceSpell.tscn")

func ShootSpell(chosenSpell):
	print("Fire1")
	#Change to shoot different spells
	if chosenSpell == Spells.SPELLBOLT:
		if SPELLBOLT:
			var spell = SPELLBOLT.instantiate()
			get_tree().current_scene.add_child(spell)
			spell.global_position = get_owner().global_position
			spell.scale = Vector2(1, 1)
			
			var spellRotation = get_owner().global_position.direction_to(get_owner().get_global_mouse_position()).angle()
			spell.rotation = spellRotation
			
	if chosenSpell == Spells.ICEBOLT:
		if ICESPELL:
			var spell = ICESPELL.instantiate()
			get_tree().current_scene.add_child(spell)
			spell.global_position = get_owner().global_position
			spell.scale = Vector2(1, 1)
			#print(Target.angle())
			var spellRotation = get_owner().global_position.direction_to(get_owner().get_global_mouse_position()).angle()
			spell.rotation = spellRotation

func ShootSpellOffset(chosenSpell, Target, Offset:Vector2 = Vector2(0,0)):
	print("Fire2")
	#Change to shoot different spells
	if chosenSpell == Spells.SPELLBOLT:
		if SPELLBOLT:
			var spell = SPELLBOLT.instantiate()
			get_tree().current_scene.add_child(spell)
			spell.global_position = get_owner().global_position + Offset
			spell.scale = Vector2(1, 1)
			#print(Target.angle())
			var spellRotation = get_owner().global_position.direction_to(Target).angle()
			spell.rotation = spellRotation
	if chosenSpell == Spells.ICEBOLT:
		if ICESPELL:
			var spell = ICESPELL.instantiate()
			get_tree().current_scene.add_child(spell)
			spell.global_position = get_owner().global_position + Offset
			spell.scale = Vector2(1, 1)
			#print(Target.angle())
			var spellRotation = get_owner().global_position.direction_to(Target).angle()
			spell.rotation = spellRotation
