extends Node

class_name BattleScene

enum Phase {START, COMMAND, EXECUTION, VICTORY, DEFEAT}

var hPanelSCN = preload("res://Scenes/Battle/HeroPanel.tscn")
var eInfoSCN = preload("res://Scenes/Battle/EnemyInfo.tscn")
var cmdPanelSCN = preload("res://Scenes/Battle/CommandPanel.tscn")
var modelSCN = preload("res://Character/Model.tscn")
var dummyTRES = preload("res://Character/Dummy.tres")

var heroes = [Hero.new("Hero 1", 1000, 100, 1, 2, 3, 4, 5, 6, 7), 
Hero.new("Hero 2", 1000, 100, 1, 2, 3, 4, 5, 6, 7), 
Hero.new("Hero 3", 1000, 100, 1, 2, 3, 4, 5, 6, 7), 
Hero.new("Hero 4", 1000, 100, 1, 2, 3, 4, 5, 6, 7)]

var enemies = [Enemy.new("Enemy 1", 1000, 100, 1, 2, 3, 4, 5, 6, 7), 
Enemy.new("Enemy 2", 1000, 100, 1, 2, 3, 4, 5, 6, 7)]

var enemy_infos = []

var items = [Potion.new()]

var current_phase = Phase.START
var command_cursor = 0
var hero_commands = []

var hero_panel : HeroPanel
var command_panel : CommandPanel

func _init():
	
	hero_panel = hPanelSCN.instance()
	hero_panel.init(heroes)
	
	command_panel = cmdPanelSCN.instance()
	
	for enemy in enemies:
		var enemyInfo = eInfoSCN.instance()
		enemyInfo.init(enemy.char_name)
		enemy_infos.append(enemyInfo)

func _ready():
	
	add_child(hero_panel)
	add_child(command_panel)
		
	for ei in enemy_infos:
		$EnemyPanel/EnemyList.add_child(ei)
		
	var newModel = modelSCN.instance()
	newModel.init(dummyTRES)
	newModel.position = $SpawnCT/SpawnH1.position
	$SpawnCT.add_child(newModel)
	
	var newModel2 = modelSCN.instance()
	newModel2.init(dummyTRES)
	newModel2.position = $SpawnCT/SpawnH2.position
	$SpawnCT.add_child(newModel2)
	
		
	change_phase(Phase.COMMAND)
	
# Changing phase
func change_phase(phase):
	match phase:
		Phase.START:
			print("Start!")
		Phase.COMMAND:
			
			command_panel.visible = true
			command_panel.set_process(true)
		Phase.EXECUTION:
			command_panel.visible = false
			command_panel.set_process(false)
		Phase.VICTORY:
			print("Victory!")
		Phase.DEFEAT:
			print("Defeat!")
	


func _process(delta):
	pass
