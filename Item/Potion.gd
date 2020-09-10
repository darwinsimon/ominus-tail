extends "res://Item/Item.gd"
class_name Potion

func _init():
	self.item_name = "Potion"
	self.description = "Restores 25% of max HP"


func on_use(target : Character) -> void:
	print("Using potion")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
