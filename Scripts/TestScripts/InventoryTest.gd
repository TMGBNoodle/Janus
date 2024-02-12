extends Node

func _ready() -> void:
	var inventory = Inventory.new()
	print(inventory)
	$InventoryController/InventoryContainer.SetInventory(inventory)
