extends "res://Character/Character.gd"

class_name Enemy

var commands = []

func get_command(enemies, heroes) -> Command:

	var selected = commands[ Global.rng.randi() % commands.size() ]
	
	# Duplicate command
	var cmd = Command.new(selected.type, selected.source, selected.item)
	
	# Attack
	if cmd.type == Command.Type.ATTACK:
		cmd.targets.append(Global.heroes[ Global.rng.randi() % heroes.size() ])


	return cmd
