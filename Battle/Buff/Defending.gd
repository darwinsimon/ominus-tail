extends "res://Battle/Buff/Buff.gd"
class_name BuffDefending

#######################
### Override functions
#######################

func _init():
	buff_name = "Defending"
	is_hidden = true
	dispel_turn = 1

func p_damage_modifier(damage : float) -> float:
	return damage / 2
