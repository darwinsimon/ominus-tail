extends Character

class_name Hero

func _init(
	char_name : String = "", 
	hp : int = 0, 
	mp : int = 0, 
	p_atk : int = 0,
	p_def : int = 0,
	m_atk : int = 0,
	m_def : int = 0,
	speed : int = 0,
	evasion : int = 0,
	aim : int = 0):
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

func _ready():
	pass # Replace with function body.
