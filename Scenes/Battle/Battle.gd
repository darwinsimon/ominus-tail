extends Node

class_name BattleScene

enum Phase {START, COMMAND, EXECUTION, VICTORY, DEFEAT}

enum Condition {IN_PROGRESS, VICTORY, DEFEAT}

var hPanelSCN = preload("res://Scenes/Battle/HeroPanel.tscn")
var ePanelSCN = preload("res://Scenes/Battle/EnemyPanel.tscn")
var cmdPanelSCN = preload("res://Scenes/Battle/CommandPanel.tscn")
var modelSCN = preload("res://Character/Model.tscn")
var dummyTRES = preload("res://Character/Dummy.tres")

var model = preload("res://Character/Model.gd")

var current_phase = Phase.START
var command_cursor = 0
var hero_commands = []

var hero_models = []
var enemy_models = []

var hero_panel : HeroPanel
var enemy_panel : EnemyPanel
var command_panel : CommandPanel


#######################
### Override functions
#######################

func _init():
	
	Global.create_battle_heroes()
	
	hero_panel = hPanelSCN.instance()
	hero_panel.init(Global.battle_heroes)
	
	enemy_panel = ePanelSCN.instance()
	enemy_panel.init(Global.enemies)
	
	command_panel = cmdPanelSCN.instance()
	

func _ready():
	
	# Connect to signal receiver
	command_panel.connect("on_finished", self, "_on_command_finished")
	command_panel.connect("on_unit_selected", self, "_on_command_unit_selected")
	command_panel.connect("on_unit_deselected", self, "_on_command_unit_deselected")
	
	add_child(hero_panel)
	add_child(enemy_panel)
	add_child(command_panel)
	
	# Spawn heroes
	for h in range(Global.battle_heroes.size()):
		var model = modelSCN.instance()
		model.init(dummyTRES)
		model.position = get_node("HeroSpawn/S"+str(h)).position
		
		hero_models.append(model)
		$HeroSpawn.add_child(model)
		
	# Spawn enemies
	for e in range(Global.enemies.size()):
		var model = modelSCN.instance()
		model.init(dummyTRES, model.Side.RIGHT)
		model.position = get_node("EnemySpawn/S"+str(e)).position
		
		enemy_models.append(model)
		$EnemySpawn.add_child(model)
	
		
	_change_phase(Phase.START)

#######################
### Private functions
#######################

# Changing phase
func _change_phase(phase):
	match phase:
		Phase.START:
			print("Start!")
			_change_phase(Phase.COMMAND)
		Phase.COMMAND:
			command_panel.start()
		Phase.EXECUTION:
			print("Start execution")
			command_panel.hide()
			_execute()
		Phase.VICTORY:
			print("Victory!")
		Phase.DEFEAT:
			print("Defeat!")
			
func _execute():
	for command in hero_commands:
		if command.type == Command.Type.DEFEND:
			print(command.source.char_name + " is defending")
		elif command.type == Command.Type.ATTACK:
			for t in command.targets:
				print(command.source.char_name + " is attacking " + t.char_name)
			
	hero_commands.clear()
	match _check_battle_condition():
		Condition.IN_PROGRESS:
			print("Still in progress")
			_change_phase(Phase.COMMAND)
		Condition.VICTORY:
			_change_phase(Phase.VICTORY)
		Condition.DEFEAT:
			_change_phase(Phase.DEFEAT)
	
func _check_battle_condition() -> int:
	
	var cond = Condition.VICTORY
	
	# Check for enemies
	for e in Global.enemies:
		if e.curr_hp != 0:
			break

	# Enemies are still alive
	cond = Condition.DEFEAT
	
	# Check for heroes
	for h in Global.battle_heroes:
		if h.curr_hp != 0:
			return Condition.IN_PROGRESS
			

	return cond

#######################
### Signal listeners
#######################

func _on_command_finished(commands):
	hero_commands = commands
	_change_phase(Phase.EXECUTION)
	
func _on_command_unit_selected(cursor : int, is_enemy : bool, select_all : bool):
	if is_enemy:
		for e in range(enemy_models.size()):
			if select_all || cursor == e:
				enemy_models[e].set_selected(true)
			else:
				enemy_models[e].set_selected(false)
		
		for h in range(hero_models.size()):
			hero_models[h].set_selected(false)
	else:
		for h in range(hero_models.size()):
			if select_all || cursor == h:
				hero_models[h].set_selected(true)
			else:
				hero_models[h].set_selected(false)
		for e in range(enemy_models.size()):
			enemy_models[e].set_selected(false)
				
func _on_command_unit_deselected():
	for e in range(enemy_models.size()):
		enemy_models[e].set_selected(false)

	for h in range(hero_models.size()):
		hero_models[h].set_selected(false)	
				
