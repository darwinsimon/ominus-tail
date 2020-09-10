extends Node

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

export(int) var evasion = 0
export(int) var aim = 0

export var statuses = []


func _init(char_name : String = "", 
	hp : int = 0, 
	mp : int = 0, 
	p_atk : int = 0,
	p_def : int = 0,
	m_atk : int = 0,
	m_def : int = 0,
	speed : int = 0,
	evasion: int = 0,
	aim: int = 0):
	self.char_name = char_name
	
	self.max_hp = hp
	self.curr_hp = hp
	self.max_mp = mp
	self.curr_mp = mp
	
	self.p_atk = p_atk
	self.p_def = p_def
	
	self.m_atk = m_atk
	self.m_def = m_def
	
	self.speed = speed
	self.evasion = evasion
	self.aim = aim
