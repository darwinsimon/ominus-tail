extends Node

signal on_knocked_out

class_name Character

export(String) var char_name = ""
export(int) var max_hp = 0
export(int) var max_mp = 0
export(int) var curr_hp = 0
export(int) var curr_mp = 0

export(int) var p_atk = 0
export(int) var p_def = 0
export(int) var m_atk = 0
export(int) var m_def = 0
export(int) var speed = 0

export(int) var evasion = 5
export(int) var aim = 100
export(int) var crit = 5

export var buffs = []
export var debuffs = []

var model : Model

func decr_hp(damage : int) -> void:
	curr_hp = curr_hp - damage
	if curr_hp < 0:
		curr_hp = 0
		emit_signal("on_knocked_out")
	
func incr_hp(restore : int) -> void:
	curr_hp = curr_hp + restore
	if curr_hp > max_hp:
		curr_hp = max_hp
