extends Resource
class_name ItemStack

var item:Item = null
var quantity:int = 0

func _init(item:Item, quantity:int) -> void:
	self.item = item
	self.quantity = quantity
