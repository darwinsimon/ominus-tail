extends Node

signal on_dispelled

class_name Buff

export(String) var buff_name = ""
export(bool) var is_debuff = false
export(bool) var is_hidden = false
export(int) var dispel_turn = 0
export(String) var description = ""

var curr_turn : int = 0

func incr_turn() -> void:
	curr_turn += 1
		
func dispel() -> void:
	emit_signal("on_dispelled", self)
	
func is_expired() -> bool:
	return curr_turn >= dispel_turn
	

# HP damage - return total damage
func hp_damage(curr_hp : int, max_hp : int) -> int:
	return 0
	
# Physical damage modifier - return modified damage
func p_damage_modifier(damage : int) -> int:
	return damage
	
# Magical damage modifier - return modified damage
func m_damage_modifier(damage : int) -> int:
	return damage
