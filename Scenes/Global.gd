extends Node


var heroes = [Hero.new("Mickey Mouse", 1000, 100, 1, 2, 3, 4, 5, 6, 7), 
Hero.new("Donald Duck", 1000, 100, 1, 2, 3, 4, 5, 6, 7), 
Hero.new("Goofy", 1000, 100, 1, 2, 3, 4, 5, 6, 7), 
Hero.new("Pluto", 1000, 100, 1, 2, 3, 4, 5, 6, 7)]

var battle_heroes = []


var enemies = [Werewolf.new(1), Werewolf.new(2)]

var items = [Potion.new()]

func create_battle_heroes():
	battle_heroes.clear()
	for hero in heroes:
		battle_heroes.append(hero.duplicate())
