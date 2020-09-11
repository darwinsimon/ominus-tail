extends "res://Enemy/Enemy.gd"
class_name Werewolf

func _init(num : int = 0):
	if num == 0:
		self.char_name = "Werewolf"
	else:
		self.char_name = "Werewolf " + str(num)
	
	self.max_hp = 100000
	self.curr_hp = 100000
	self.max_mp = 10000
	self.curr_mp = 10000
	
	self.p_atk = 100
	self.p_def = 100
	
	self.m_atk = 100
	self.m_def = 100
	
	self.speed = 100
	self.evasion = 0
	self.aim = 100
