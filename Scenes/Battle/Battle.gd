extends Node
class_name BattleScene

var hPanelSCN = preload("res://Scenes/Battle/HeroPanel.tscn")
var ePanelSCN = preload("res://Scenes/Battle/EnemyPanel.tscn")
var cmdPanelSCN = preload("res://Scenes/Battle/CommandPanel.tscn")
var modelSCN = preload("res://Character/Model.tscn")
var fTextSCN = preload("res://Scenes/Battle/FloatingText/FloatingText.tscn")
var dummyTRES = preload("res://Character/Dummy.tres")

var hero_panel : HeroPanel
var enemy_panel : EnemyPanel
var command_panel : CommandPanel
var controller : BattleController

#######################
### Override functions
#######################

func _init():
	
	# Dummy
	Global.create_battle_heroes()
	Global.create_enemies()

	# Initiate controller
	controller = BattleController.new()

	# Hero Panel
	hero_panel = hPanelSCN.instance()
	hero_panel.init(controller.hero_infos)

	# Enemy Panel
	enemy_panel = ePanelSCN.instance()
	enemy_panel.init(controller.enemy_infos)

	# Command Panel
	command_panel = cmdPanelSCN.instance()


func _ready():
	
	# Connect to signal receiver
	command_panel.connect("on_finished", controller, "_on_command_finished")
	command_panel.connect("on_unit_selected", controller, "_on_command_unit_selected")
	command_panel.connect("on_unit_deselected", controller, "_on_command_unit_deselected")
	
	
	controller.executor.connect("on_finished", controller, "_on_ex_finished")
	controller.executor.connect("on_condition_changed", controller, "_on_ex_condition_changed")
	controller.executor.connect("on_damage_inflicted", controller, "_on_ex_damage_inflicted")
	controller.executor.connect("on_target_knocked_out", controller, "_on_ex_target_knocked_out")
	controller.executor.connect("on_new_buff", controller, "_on_ex_new_buff")
	
	
	controller.connect("on_phase_changed", self, "_on_ctrl_phase_changed")
	controller.connect("on_show_damage_text", self, "_on_ctrl_show_damage_text")
	
	add_child(hero_panel)
	add_child(enemy_panel)
	add_child(command_panel)

	# Spawn heroes
	for h in range(Global.heroes.size()):
		var mdl = modelSCN.instance()
		mdl.init(dummyTRES)
		mdl.position = get_node("HeroSpawn/S"+str(h)).position
		Global.heroes[h].model = mdl
		$HeroSpawn.add_child(mdl)
		
	# Spawn enemies
	for e in range(Global.enemies.size()):
		var mdl = modelSCN.instance()
		mdl.init(dummyTRES, Model.Side.RIGHT)
		mdl.position = get_node("EnemySpawn/S"+str(e)).position
		Global.enemies[e].model = mdl
		$EnemySpawn.add_child(mdl)
	
		
	controller.start()



#######################
### Signal listeners
#######################

func _on_ctrl_phase_changed(phase : int) -> void:
	match phase:
		BattleController.Phase.START:
			print("Start!")
		BattleController.Phase.COMMAND:
			command_panel.start()
		BattleController.Phase.EXECUTION:
			command_panel.hide()
		BattleController.Phase.END:
			print("End!")
		BattleController.Phase.VICTORY:
			print("Victory!")
		BattleController.Phase.DEFEAT:
			print("Defeat!")

func _on_ctrl_show_damage_text(damage : String, position : Vector2) -> void:
	var dmg = fTextSCN.instance()
	dmg.set_text(damage)
	dmg.position = position
	add_child(dmg)
