extends Sprite2D

signal completed

var target
var duration
# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("completed")

func initialize(ntarget, nduration):
	target = ntarget
	duration = nduration
	await Signal(self, "completed")
	launch()
	
	
func launch():
	var tween = create_tween().parallel()
	var currentscale = self.scale
	tween.tween_property(self, "position", target, duration)
	tween.tween_callback(self.queue_free)
