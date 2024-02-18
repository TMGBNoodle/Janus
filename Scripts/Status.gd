extends Node2D
var statusEffects = load("res://Scripts/StatusEffects.gd")

@export var max_health : int = 200
@export var timerLength = 1
@export var regen : int = 1

@onready var regenTween

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func Regen():
	regenTween = create_tween()
	var regenTime = max_health - health / 2
	regenTween.interpolate_value(health, max_health-health, 0, regenTime, 0, 0)
	regenTween.play()

func Damage(damage):
	if regenTween:
		regenTween.kill()
	damage_timer.stop()
	damage_timer.wait_time = timerLength
	var new_health : int = int(clamp(health - damage, 0, max_health))
	self.health = new_health
	print(new_health)
	damage_timer.start()
	if health <= 0:
		Destroy()
	pass
	
func _ready():
	print(damage_timer)
	damage_timer = get_node("damageTimer")
	print(damage_timer, 2)
	damage_timer.timeout.connect(Regen)
	Regen()
	pass # Replace with function body.


func _on_hurtbox_area_entered(hitbox):
	if hitbox.name == "Hitbox":
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
