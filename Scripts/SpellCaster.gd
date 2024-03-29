extends Node

var SpellOrigin
var tweenBar : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	tweenBar = self.get_parent().get_node("RegenBar")

enum Spells 
{
	SPELLBOLT,
	ICEBOLT,
	BARRAGE
}
var debounce = false
var selectedspell = Spells.SPELLBOLT
var cooldown = 0.5
func _physics_process(_delta):
	if(Input.is_action_just_pressed("ActionAttack")):
		if debounce == false:
			tweenBar.scale = Vector2(0.01, 0.43)
			debounce = true
			ShootSpell(selectedspell)
			var reload = create_tween()
			reload.tween_property(tweenBar, "scale", Vector2(1, 0.43), cooldown)
			reload.tween_callback(debouncist)
			
	elif(Input.is_action_just_pressed("SpellSwitch")):
		if selectedspell == Spells.SPELLBOLT:
			selectedspell = Spells.ICEBOLT
			cooldown = 1.5
		elif selectedspell == Spells.ICEBOLT:
			selectedspell = Spells.SPELLBOLT
			cooldown = 0.5

func debouncist():
	debounce = false
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
