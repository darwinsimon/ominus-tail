extends Node
class_name BattleController

signal on_phase_changed

enum Phase {START, COMMAND, EXECUTION, END, VICTORY, DEFEAT}

var eInfoSCN = preload("res://Scenes/Battle/EnemyInfo.tscn")
var hInfoSCN = preload("res://Scenes/Battle/HeroInfo.tscn")

var enemy_infos = []
var hero_infos = []

var enemy_models = []
var hero_models = []

var executor : Executor
var buff_ticker : BuffTicker

#######################
### Override functions
#######################

func _init():
	for hero in Global.heroes:
		var heroInfo = hInfoSCN.instance()
		heroInfo.init(hero)
		hero_infos.append(heroInfo)
	
	for enemy in Global.enemies:
		var enemyInfo = eInfoSCN.instance()
		enemyInfo.init(enemy)
		enemy_infos.append(enemyInfo)
	
	executor = Executor.new()
	buff_ticker = BuffTicker.new()


#######################
### Public functions
#######################

func start():
	_change_phase(Phase.START)
	

#######################
### Private functions
#######################

# Changing phase
func _change_phase(phase):
	match phase:
		Phase.START:
			# TODO
			print("Start!")
			_change_phase(Phase.COMMAND)
		Phase.COMMAND:
			emit_signal("on_phase_changed", Phase.COMMAND)
		Phase.EXECUTION:
			emit_signal("on_phase_changed", Phase.EXECUTION)
			executor.do()
		Phase.END:
			_end_phase()
		Phase.VICTORY:
			# TODO
			print("Victory!")
		Phase.DEFEAT:
			# TODO
			print("Defeat!")
			

func _end_phase():
	buff_ticker.tick_buff(Global.heroes)
	buff_ticker.tick_buff(Global.enemies)
	
	# Back to START Phase
	_change_phase(Phase.START)

#######################
### Signal listeners
#######################

# Execution has finished - Move to END Phase
func _on_executor_finished():
	print("executor finished")
	_change_phase(Phase.END)

func _on_executor_condition_changed(condition : int) -> void:
	print("executor changed")
	if condition == Executor.Condition.VICTORY:
		# TODO
		print("Victory")
	else:
		# TODO
		print("Defeat")


# Command is set - Move to EXECUTION Phase
func _on_command_finished(commands):
	
	# Add DEFENDING buff for heroes
	for c in commands:
		if c.type == Command.Type.DEFEND:
			buff_ticker.add_buff(c.source, BuffDefending.new())
	
	# Set commands for enemies
	for e in Global.enemies:
		commands.append(e.get_command(Global.enemies, Global.heroes))

	executor.set_commands(commands)
	_change_phase(Phase.EXECUTION)
	
# Set cursor for selected units
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

# Remove cursors
func _on_command_unit_deselected():
	for e in enemy_models:
		e.set_selected(false)

	for h in hero_models:
		h.set_selected(false)	
				
func _on_executor_damage_inflicted(damage : int, target : Character):
	if target is Enemy:
		for e in enemy_infos:
			if e.enemy_name == target.char_name:
				print(e.enemy_name + " got " + str(damage) + " damage")
				break
	else:
		for h in hero_infos:
			if h.hero_name == target.char_name:
				h.set_new_hp(target.curr_hp)
				break
