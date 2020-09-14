extends "res://Battle/Buff/Buff.gd"
class_name BuffKnockedOut

#######################
### Override functions
#######################

func _init():
	buff_name = "Knocked Out"
	is_debuff = true
	dispel_turn = 0
	is_dispelable = false
