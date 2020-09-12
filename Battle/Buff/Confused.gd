extends "res://Battle/Buff/Buff.gd"
class_name BuffConfused

#######################
### Override functions
#######################

func _init():
	buff_name = "Confused"
	is_debuff = true
	dispel_turn = 3
