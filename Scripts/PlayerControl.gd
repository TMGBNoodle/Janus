extends Area2D

@export var Speed = 50
@onready var health = get_node("Status")

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var right = 0
	var up = 0
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("Right"):
		right = 1
	elif Input.is_action_pressed("Left"):
		right = -1
	else:
		right = 0
		
		
	if Input.is_action_pressed("Up"):
		up = -1
	elif Input.is_action_pressed("Down"):
		up = 1
	else:
		up = 0
		
	if right != 0:
		velocity.x += right
	elif abs(velocity.x) < 0.5:
		velocity.x = 0
	else:
		velocity.x += sign(velocity.x)
		
	if up != 0:
		velocity.y += up
	elif abs(velocity.y) < 0.5:
		velocity.y = 0
	else:
		velocity.y -= sign(velocity.y)

	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.flip_v = velocity.y < 0
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * Speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	if position.x < 0:
		position.x = screen_size.x
	elif position.x > screen_size.x:
		position.x = 0
	if position.y  < 0:
		position.y = screen_size.y
	elif position.y > screen_size.y:
		position.y = 0
	
#Things that need physics math go here

