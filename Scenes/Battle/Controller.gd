extends Node
class_name BattleController

signal on_phase_changed
signal on_show_damage_text

enum Phase {START, COMMAND, EXECUTION, END, VICTORY, DEFEAT}

var eInfoSCN = preload("res://Scenes/Battle/EnemyInfo.tscn")
var hInfoSCN = preload("res://Scenes/Battle/HeroInfo.tscn")

var enemy_infos = []
var hero_infos = []

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

func start() -> void:
	_change_phase(Phase.START)
	

#######################
### Private functions
#######################

# Changing phase
func _change_phase(phase) -> void:
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
			

func _end_phase() -> void:
	buff_ticker.tick_buff(Global.heroes)
	buff_ticker.tick_buff(Global.enemies)
	
	# Back to START Phase
	_change_phase(Phase.START)

#######################
### Signal listeners
#######################

# Execution has finished - Move to END Phase
func _on_ex_finished() -> void:
	_change_phase(Phase.END)

func _on_ex_condition_changed(condition : int) -> void:
	if condition == Executor.Condition.VICTORY:
		# TODO
		print("Victory")
	else:
		# TODO
		print("Defeat")


# Command is set - Move to EXECUTION Phase
func _on_command_finished(commands) -> void:
	
	# Set commands for enemies
	for e in Global.enemies:
		commands.append(e.get_command(Global.enemies, Global.heroes))

	executor.set_commands(commands)
	_change_phase(Phase.EXECUTION)
	
# Set cursor for selected units
func _on_command_unit_selected(
		cursor : int,
		is_enemy : bool,
		select_all : bool) -> void:
	if is_enemy:
		for e in range(Global.enemies.size()):
			if select_all || cursor == e:
				Global.enemies[e].model.set_selected(true)
			else:
				Global.enemies[e].model.set_selected(false)
		
		for h in range(Global.heroes.size()):
			Global.heroes[h].model.set_selected(false)
	else:
		for h in range(Global.heroes.size()):
			if select_all || cursor == h:
				Global.heroes[h].model.set_selected(true)
			else:
				Global.heroes[h].model.set_selected(false)
		for e in range(Global.enemies.size()):
			Global.enemies[e].model.set_selected(false)

# Remove cursors
func _on_command_unit_deselected() -> void:
	for e in Global.enemies:
		e.model.set_selected(false)

	for h in Global.heroes:
		h.model.set_selected(false)	
				
func _on_ex_damage_inflicted(damage : int, target : Character) -> void:
	if target is Enemy:
		for e in enemy_infos:
			if e.enemy_name == target.char_name:
				emit_signal("on_show_damage_text", str(damage), target.model.global_position)
				break
	else:
		for h in hero_infos:
			if h.hero_name == target.char_name:
				h.set_new_hp(target.curr_hp)
				emit_signal("on_show_damage_text", str(damage), target.model.global_position)
				break

# Target is knocked out
func _on_ex_target_knocked_out(target : Character) -> void:
	print("TODO")

# Add new buff
func _on_ex_new_buff(target : Character, buff : Buff) -> void:
	buff_ticker.add_buff(target, buff)
	
	
	
	
