extends Node

signal damaged
signal healing

@export var max_health : int = 200
@export var timerLength = 1
@export var regen : int = 1

@onready var regenTween

@export var health := max_health :
	set(value):
		health = set_health(value)
	get:
		return health
		
func set_health(__new_health : int):
	return int(clamp(__new_health, 0, max_health))

@onready var damage_timer : Timer = get_node("DamageTimer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	await damage_timer
	
func Regen():
	await regen_timer()
	await heal()

func heal():
	print(healing)
	
func regen_timer():
	get_tree().create_timer(timerLength).timeout
	
func Damage(damage):
	damage_timer.stop()
	damage_timer.wait_time = timerLength
	var new_health : int = int(clamp(health - damage, 0, max_health))
	set_health(new_health)
	damage_timer.start()
	Regen()

	
func _ready():
	damage_timer.timeout.connect(Regen)
	Regen()
	pass # Replace with function body.


func _on_hurtbox_area_entered(hitbox):
	self.Damage(hitbox.damage)
	print("Enemy Hit")
