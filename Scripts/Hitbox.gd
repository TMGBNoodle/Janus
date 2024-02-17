extends Area2D

@export var damage = 10
@export var slow: bool = false

var effects = []


# Called when the node enters the scene tree for the first time.
func _ready():
	if slow:
		effects.append(StatusEffectProperties.statusEffects.SLOW)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


