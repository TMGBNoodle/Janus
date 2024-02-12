extends Resource

class_name Inventory

signal slot_changed(index, oldContent, newContent)

@export var maxSlots:int = 30

var slots = []

func _init() -> void:
	var items = [preload("res://Items/BadCoin.tres")]
	for i in maxSlots: # for i in range(0, max_slots):
		slots.push_back(ItemStack.new(null, 0))

	for i in maxSlots:
		if randi() % 2 == 1:
			continue

		items.shuffle()

		SetItemStack(i, items[0], int(randf_range(1, 5)))


func SetItemStack(index:int, item:Item, quantity:int) -> void:
	var oldContent = slots[index]
	slots[index] = ItemStack.new(item, quantity)
	emit_signal("slot_changed", index, oldContent, slots[index])

func GetItemStack(index:int) -> ItemStack:
	return slots[index]

