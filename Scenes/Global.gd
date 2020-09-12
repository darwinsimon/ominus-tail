extends Node

var rng = RandomNumberGenerator.new()

var setup_heroes = [Hero.new("Mickey Mouse", 1000, 100, 100, 100, 3, 4, 5, 6, 7), 
Hero.new("Donald Duck", 1000, 100, 50, 50, 3, 4, 5, 6, 7), 
Hero.new("Goofy", 1000, 100, 150, 150, 3, 4, 5, 6, 7), 
Hero.new("Pluto", 1000, 100, 200, 200, 3, 4, 5, 6, 7)]

var heroes = []
var enemies = []

var items = [Potion.new()]

func _ready():
	rng.randomize()

func create_battle_heroes():
	heroes.clear()
	for hero in setup_heroes:
		heroes.append(hero.duplicate())

func create_enemies():
	enemies.clear()
	enemies.append(Werewolf.new(1))
	enemies.append(Werewolf.new(2))
