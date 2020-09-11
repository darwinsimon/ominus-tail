extends Node
class_name Selector

signal on_confirmed
signal on_changed
signal on_canceled

var cursor = 0
var is_enemy = false
var select_all = false
var allow_enemy = false
var allow_ally = false

var cmd : Command

#######################
### Override functions
#######################

func _ready():
	set_process_input(false)


func _input(event : InputEvent):
	if event.is_action_pressed("ui_accept"):
		_confirm()
	elif event.is_action_pressed("ui_cancel"):
		_cancel()
	else:
		var new_selected : int = cursor
		var new_side : bool = is_enemy
		var total_enemies : int = Global.enemies.size()
		var total_heroes : int = Global.heroes.size()
		
		if event.is_action_pressed("ui_right") && allow_ally && is_enemy:
			new_selected = 0
			new_side = false
		elif event.is_action_pressed("ui_left") && allow_enemy && !is_enemy:
			new_selected = 0
			new_side = true
		elif event.is_action_pressed("ui_down") && !select_all:
			new_selected += 1
		elif event.is_action_pressed("ui_up") && !select_all && new_selected > 0:
			new_selected -= 1
			
		if new_side && total_enemies <= new_selected:
			new_selected = total_enemies - 1
		elif !new_side && total_heroes <= new_selected:
			new_selected = total_heroes - 1
		
		if new_selected != cursor || new_side != is_enemy:
			is_enemy = new_side
			cursor = new_selected
			emit_signal("on_changed", cursor, is_enemy, select_all)
			
			
#######################
### Private functions
#######################

func _cancel():
	emit_signal("on_canceled")
	set_process_input(false)

func _confirm():
	emit_signal("on_confirmed", cmd, cursor, is_enemy, select_all)
	set_process_input(false)
	
#######################
### Public functions
#######################

func start(
	cmd : Command,
	is_enemy : bool = false,
	select_all : bool = false,
	allow_enemy : bool = false,
	allow_ally : bool = false) -> void:
	cursor = 0
	self.cmd = cmd
	self.is_enemy = is_enemy
	self.select_all = select_all
	self.allow_enemy = allow_enemy
	self.allow_ally = allow_ally
	set_process_input(true)
	emit_signal("on_changed", cursor, is_enemy, select_all)

