extends Node


@export var max_health : int = 200
@export var timerLength = 1
@export var regen : int = 1

@onready var regenTween

signal node_destroyed

@export var health := max_health :
	set(value):
		health = set_health(value)
	get:
		return health
		
func set_health(__new_health : int):
	return int(clamp(__new_health, 0, max_health))

@onready var damage_timer : Timer = get_node("DamageTimer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	damage_timer.start()
	if self.health <= 0:
		self.Destroy()
	pass
	
func _ready():
	damage_timer.timeout.connect(Regen)
	Regen()
	pass # Replace with function body.


func _on_hurtbox_area_entered(hitbox):
	var base_damage = hitbox.damage
	self.Damage(hitbox.damage)
	print("Enemy Hit")
	
func Destroy():
	emit_signal("node_destroyed")
	self.queue_free
