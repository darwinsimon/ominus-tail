extends Node
class_name Executor

signal on_condition_changed
signal on_finished
signal on_damage_inflicted

enum Condition {IN_PROGRESS, VICTORY, DEFEAT}

var commands = []


#######################
### Private functions
#######################

func _check_battle_condition() -> int:
	
	var cond = Condition.VICTORY
	
	# Check for enemies
	for e in Global.enemies:
		if e.curr_hp != 0:
			break

	# Enemies are still alive
	cond = Condition.DEFEAT
	
	# Check for heroes
	for h in Global.heroes:
		if h.curr_hp != 0:
			return Condition.IN_PROGRESS
			

	return cond
	
func _attack(cmd : Command):
	
	var target : Character = cmd.targets[0]
	
	for db in cmd.source.debuffs:
		
		# Check for Confused debuff - 25% hit allies
		if db is BuffConfused && Global.rng.randi() % 4 == 0:
			
			# Get allies
			var allies = []
			if cmd.source is Enemy:
				allies = Global.enemies
			else:
				allies = Global.heroes
				
			# Override target
			target = allies[ Global.rng.randi() % allies.size() ]
		
	var damage = _calculate_damage(cmd.source, target, false)
	target.decr_hp(damage)
	emit_signal("on_damage_inflicted", damage, target)

	print(cmd.source.char_name + " attacked " + target.char_name + " for " + str(damage))

func _calculate_damage(attacker : Character, target : Character, is_magical : bool = false) -> int:
	
	var attack : float = float(attacker.p_atk)
	var defend : float = float(target.p_def)
	
	if is_magical:
		attack = float(attacker.m_atk)
		defend = float(target.m_def)
		
	var damage : float = attack / defend * 100
	var margin : float = damage * Global.rng.randf_range(-5.0, 5.0) / 100
	
	var final_damage = damage + margin
	if final_damage <= 0:
		final_damage = 0
	
	return int(final_damage)
	
	
#######################
### Public functions
#######################

func set_commands(cmd : Array) -> void:
	commands.clear()
	commands = cmd.duplicate(true)
	commands.sort_custom(CommandSorter, "sort")

func do() -> void:
	for cmd in commands:
		
		# DEFEND
		if cmd.type == Command.Type.DEFEND:
			print(cmd.source.char_name + " is defending")
		
		# ATTACK
		elif cmd.type == Command.Type.ATTACK:
			_attack(cmd)

		# Check for victory or defeat
		match _check_battle_condition():
			Condition.VICTORY:
				emit_signal("on_condition_changed", Condition.VICTORY)
				return
			Condition.DEFEAT:
				emit_signal("on_condition_changed", Condition.DEFEAT)
				return
				
	emit_signal("on_finished")



# Speed sorter
class CommandSorter:
	static func sort(a, b):
		if a.source.speed > b.source.speed:
			return true
		elif a.source.speed == b.source.speed:
			if a.source is Hero && b.source is Enemy:
				return true
		return false
