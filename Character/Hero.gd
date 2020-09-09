extends "res://Character/Character.gd"

class_name Hero
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _init(
	char_name : String = "", 
	hp : int = 0, 
	mp : int = 0, 
	p_atk : int = 0,
	p_def : int = 0,
	m_atk : int = 0,
	m_def : int = 0,
	speed : int = 0):
		
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
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
