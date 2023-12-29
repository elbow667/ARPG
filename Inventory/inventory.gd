extends Resource
class_name Inventory

signal updated

@export var slots: Array[InventorySlot]

func insert(item: InventoryItem):
	# reference video: How to Make an Inventory in Godot 4.1 #4: stacking items: Sept 16, 2023
	# using filter function and lambda function refer to documentation
	# note: she types this out at around 5:36 then the screen refreshes with extended code
	# this code is cut off the screen and my best attempt to guess as to what the rest of it is, was wrong.
	# I had to cut it out.  Upon testing this seems to work well enough.
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if !itemSlots.is_empty():
		itemSlots[0].amount += 1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1

	updated.emit()

func removeItemAtIndex(index: int):
	slots[index] = InventorySlot.new()
	
func insertSlot(index: int, inventorySlot: InventorySlot):
	var oldIndex: int = slots.find(inventorySlot)
	removeItemAtIndex(oldIndex)
	
	slots[index] = inventorySlot

