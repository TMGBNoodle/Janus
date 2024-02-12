extends PanelContainer

@onready var nItemsContainer = find_child("ItemContainer")

var inventory:Inventory = null

func SetInventory(inventory:Inventory) -> void:
	print(inventory)
	self.inventory = inventory
	nItemsContainer.SetInventory(inventory)
