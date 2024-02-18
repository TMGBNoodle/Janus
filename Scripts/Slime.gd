extends Node2D

var slimeTexture

var slimeMoveSprites = []
var slimeIdleSprites = []

var slimeMoveIndex = 0
var slimeIdleIndex = 0

var nextFrame = true
var frameWaitTime = 0.5

var moveSpeed = 100
var isSlowed = false

var moveDirection: Vector2 = Vector2(0,0)

var playerNode

# Called when the node enters the scene tree for the first time.
func _ready():
	slimeTexture = get_node("EnemyBase").get_node("EnemySprite")
	
	playerNode = get_node("/root/WorldNode/Player")
	
	slimeMoveSprites.append("res://Sprites/EnemySprites/Slime/SlimeMove1.png")
	slimeMoveSprites.append("res://Sprites/EnemySprites/Slime/SlimeMove2.png")
	slimeMoveSprites.append("res://Sprites/EnemySprites/Slime/SlimeMove3.png")
	slimeMoveSprites.append("res://Sprites/EnemySprites/Slime/SlimeMove4.png")
	slimeIdleSprites.append("res://Sprites/EnemySprites/Slime/SlimeIdle.png")
	slimeIdleSprites.append("res://Sprites/EnemySprites/Slime/SlimeIdle2.png")
	slimeIdleSprites.append("res://Sprites/EnemySprites/Slime/SlimeIdle3.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var processedMoveSpeed = moveSpeed
	if isSlowed:
		processedMoveSpeed = processedMoveSpeed * StatusEffectProperties.slowSpeedModifier
	self.position = self.position.move_toward(playerNode.position, delta * processedMoveSpeed)
	
	TurnTowardsPlayer()
	if nextFrame:
		ChangeMoveSprite()
		WaitForNextFrame(frameWaitTime)

func ChangeMoveSprite():
	slimeIdleIndex = 0
	SwitchFrame(slimeMoveSprites[slimeMoveIndex])
	if slimeMoveIndex < slimeMoveSprites.size() - 1:
		slimeMoveIndex += 1
	else:
		slimeMoveIndex = 0
	
func ChangeIdleSprite():
	SwitchFrame(slimeIdleSprites[slimeIdleIndex])
	slimeMoveIndex += 1

func SwitchFrame(frame):
	print("here")
	slimeTexture.texture = load(frame)
	nextFrame = false

func WaitForNextFrame(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	nextFrame = true

func TurnTowardsPlayer():
	if playerNode:
		var slimeRotation = self.global_position.direction_to(playerNode.position).angle()
		self.rotation = slimeRotation
	
func Destroy():
	self.queue_free()

func _on_enemy_base_enemy_base_destroyed():
	print("dead")
	self.Destroy()
