extends Node2D

var possibleEffects = []
var possibleEffectTypes = []
var possibleTargets = []
var spriteFrames = []

var nextFrame: bool = true
var frameIndex: int = 0
var frameNum: int = 0

#multispell effect variables
var maxSpells: int = 5
var spellCircleRadius: float = 70.0

@export var waitTime:float = 1.0
@export var SPELLBOLT: PackedScene = preload("res://Scenes/Bolt.tscn")
@export var Barrage: PackedScene = preload("res://Scenes/Barrage.tscn")

#effect type enum
enum{SPELL, STATUSEFFECT}

# Called when the node enters the scene tree for the first time.
func _ready():
	spriteFrames.append("res://TheDoor/Sprites/TheDoor.png")
	spriteFrames.append("res://TheDoor/Sprites/TheDoor2.png")
	
	frameNum = spriteFrames.size()
	
	#Bolt added to possible effects
	possibleEffects.append(SPELLBOLT)
	possibleEffectTypes.append(SPELL)
	
	#adding player to targets
	var playerNode = get_node("/root/WorldNode/Player")
	possibleTargets.append(playerNode)
	
	#adding enemies to targets
	var enemyNode = get_node("/root/WorldNode/Enemies")
	if enemyNode:
		var enemyArray = enemyNode.get_children()
		possibleTargets.append_array(enemyArray)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if nextFrame and frameIndex < frameNum:
		SwitchFrame(spriteFrames[frameIndex])
		WaitForNextFrame(waitTime)
	if frameIndex == frameNum:
		CastEffect()
		self.queue_free()
		

#Make cast on animation frame

func CastEffect():
	if possibleEffects.size() > 0 and possibleTargets.size() > 0:
		var effectIndex = randi_range(0, possibleEffects.size() - 1)
		var targetIndex = randi_range(0, possibleTargets.size() - 1)
		var numSpells = randi_range(1, maxSpells)
		if possibleEffectTypes[effectIndex] == SPELL:
			#circle spell summoning logic
			var angle = 360 / numSpells
			var spellAngle = angle
			
			for i in numSpells:
				var xOffset = spellCircleRadius * (cos(spellAngle))
				var yOffset = spellCircleRadius * (sin(spellAngle))
				print(Vector2(xOffset, yOffset))
				self.get_node("SpellCaster").ShootSpellOffset(possibleTargets[targetIndex].global_position, Vector2(xOffset, yOffset))
				spellAngle += spellAngle

func SwitchFrame(frame):
	self.get_node("TheDoorSprite").texture = load(frame)
	nextFrame = false

func WaitForNextFrame(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	nextFrame = true
	frameIndex += 1
