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

export var statuses = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
