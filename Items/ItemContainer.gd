extends PanelContainer

const ITEM_SLOT_SCENE = preload("res://Items/ItemSlot.tscn")

@onready var nItemGrid = find_child("ItemGrid")


var inventory:Inventory = null

func SetInventory(inventory:Inventory) -> void:
	self.inventory = inventory

	for i in inventory.maxSlots:
		var stack = inventory.GetItemStack(i)
		var slot = ITEM_SLOT_SCENE.instantiate()
		nItemGrid.add_child(slot)
		slot.SetItemAndQuantity(i, stack.item, stack.quantity)
