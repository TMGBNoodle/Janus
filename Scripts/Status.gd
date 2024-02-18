extends Node2D
#var statusEffects = load("res://Scripts/StatusEffects.gd")

@export var max_health : int = 200
@export var timerLength = 5
@export var timeBetween = 1
@export var regen : int = 1

@onready var regenTween

var damaged = false

signal status_destroyed
signal status_slow

var effects = []

@export var health := max_health :
	set(value):
		health = set_health(value)
	get:
		return health
		
func set_health(__new_health : int):
	return int(clamp(__new_health, 0, max_health))

@onready var damage_timer : Timer = get_node("damageTimer")



func RegenTimer():
	await get_tree().create_timer(timeBetween).timeout

func Damage(damage):	
	print(str(damage) + " damage dealt")
	damaged = true
	damage_timer.stop()
	damage_timer.wait_time = timerLength
	var new_health : int = int(clamp(health - damage, 0, max_health))
	self.health = new_health
	damage_timer.start()
	if health <= 0:
		Destroy()
	
func _ready():
	pass # Replace with function body.


func _on_hurtbox_area_entered(hitbox):
	var base_damage = hitbox.damage
	effects = hitbox.effects
	self.Damage(hitbox.damage)
	ManageEffects()
	#print("Enemy Hit")
	
func Destroy():
	emit_signal("status_destroyed")
	
func SendSlowSignal():
	emit_signal("status_slow")

func ManageEffects():
	for i in effects:
		match i:
			StatusEffectProperties.statusEffects.SLOW:
				SendSlowSignal()


func _on_damage_timer_timeout():
	damaged = false
	while health < max_health:
		await RegenTimer()
		if damaged:
			break
		health += regen
