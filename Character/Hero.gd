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
	aim : int = 0).(char_name, hp, mp, p_atk, p_def, m_atk, m_def, speed, evasion, aim):
	pass

func _ready():
	pass # Replace with function body.
