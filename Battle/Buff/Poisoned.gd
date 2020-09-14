extends "res://Battle/Buff/Buff.gd"
class_name BuffPoisoned

#######################
### Override functions
#######################

func _init():
	buff_name = "Poisoned"
	is_debuff = true
	dispel_turn = 6
	
# HP damage - return total damage
func hp_damage(curr_hp : int, max_hp : int) -> float:
	return float(max_hp) / 16
