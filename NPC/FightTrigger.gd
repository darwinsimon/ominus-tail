extends "res://NPC/NPC.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



#func _ready():


func can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Player
	
func interact():
	print("Interacting")
	print(get_tree().change_scene("res://Scenes/Battle.tscn"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
