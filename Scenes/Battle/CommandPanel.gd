extends Control
class_name CommandPanel

signal on_finished
signal on_unit_selected
signal on_unit_deselected

const max_hero = 4

var l1SCN = preload("res://Scenes/Battle/Command/Level1Command.tscn")
var l1Menu = preload("res://Scenes/Battle/Command/Level1Command.gd")

#######################
### Variables
#######################

var selector : Selector
var l1_panel : Level1Command

var curr_hero : int = 0
var commands = []

#######################
### Override functions
#######################
func _init():
	
	l1_panel = l1SCN.instance()
	l1_panel.update_hero_name(str(curr_hero))
	
	selector = Selector.new()
	

func _ready():
	
	visible = false
	
	# Connect to signal receiver
	l1_panel.connect("on_selected", self, "_on_l1_selected")
	l1_panel.connect("on_canceled", self, "_on_l1_canceled")
	selector.connect("on_confirmed", self, "_on_selector_confirmed")
	selector.connect("on_changed", self, "_on_selector_changed")
	selector.connect("on_canceled", self, "_on_selector_canceled")
	
	add_child(l1_panel)
	
	add_child(selector)

#######################
### Public functions
#######################

func start():
	curr_hero = 0
	visible = true
	commands.clear()
	l1_panel.set_process_input(true)
	l1_panel.update_hero_name(str(curr_hero))

func hide():
	visible = false
	l1_panel.set_process_input(false)
	

#######################
### Private functions
#######################

func _set_hero_command(cmd : Command):
	commands.append(cmd)
	curr_hero += 1
	if curr_hero < max_hero:
		l1_panel.update_hero_name(str(curr_hero))
	elif curr_hero >= max_hero:
		emit_signal("on_finished", commands)
		
func _process_selected_command(cmd : Command, cursor : int, is_enemy : bool, select_all : bool):
	if is_enemy:
		for e in range(Global.enemies.size()):
			if select_all || cursor == e:
				cmd.targets.append(Global.enemies[e])
	else:
		for h in range(Global.heroes.size()):
			if select_all || cursor == h:
				cmd.targets.append(Global.heroes[h])
	_set_hero_command(cmd)


#######################
### Signal listeners
#######################

func _on_l1_selected(selected : int):
	match selected:
		l1Menu.Menu.ATTACK:
			var cmd = Command.new(Command.Type.ATTACK, Global.heroes[curr_hero])
			selector.start(cmd, true, false, true, true)
			l1_panel.set_process_input(false)
	match selected:
		l1Menu.Menu.DEFEND:
			var cmd = Command.new(Command.Type.DEFEND, Global.heroes[curr_hero])
			_set_hero_command(cmd)
	match selected:
		l1Menu.Menu.SKILL:
			print("Skilling")
	match selected:
		l1Menu.Menu.ITEM:
			print("Iteming")
		

func _on_l1_canceled():
	if curr_hero > 0:
		commands.pop_back()
		curr_hero -= 1
		l1_panel.update_hero_name(str(curr_hero))

		
func _on_selector_confirmed(cmd : Command, cursor : int, is_enemy : bool, select_all : bool):
	emit_signal("on_unit_deselected")
	_process_selected_command(cmd, cursor, is_enemy, select_all)
	l1_panel.set_process_input(true)
	
func _on_selector_changed(cursor : int, is_enemy : bool, select_all : bool):
	emit_signal("on_unit_selected", cursor, is_enemy, select_all)
	
func _on_selector_canceled():
	emit_signal("on_unit_deselected")
	l1_panel.set_process_input(true)
