extends "res://Battle/Buff/Buff.gd"
class_name BuffConfused

#######################
### Override functions
#######################

func _init():
	buff_name = "Confused"
	is_debuff = true
	dispel_turn = 3

func before_attack_modifier(source : Character,
	target : Character,
	allies : Array) -> Character:
	
	# 25% hit allies
	if Global.rng.randi() % 4 == 0:
			
		# Override target
		return allies[ Global.rng.randi() % allies.size() ]
	
	return target
