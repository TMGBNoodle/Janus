extends PanelContainer

class_name ItemSlot

@onready var nIconTexture = find_child("IconTexture")
@onready var nQuantityLabel = find_child("QuantityLabel")

var item:Item = null
var quantity:int = 0

var inventoryIndex:int = -1

func SetItemAndQuantity(index:int, newItem:Item, newQuantity:int = 1) -> void:
	self.inventoryIndex = index
	self.item = newItem
	if not newItem:
		newQuantity = 0
	self.quantity = newQuantity

func SetItem(newItem:Item) -> void:
	item = newItem
	if not is_inside_tree():
		await(self.ready)
	if not item:
		nIconTexture = null
	else:
		nIconTexture.texture = item.texture
	
func setQuantity(newQuantity:int) -> void:
	quantity = newQuantity
	
	if not is_inside_tree():
		await(self.ready)
	
	if quantity < 1:
		nQuantityLabel.visible = false
	else:
		nQuantityLabel.visible = true
		nQuantityLabel.text = "x%s" % quantity
