extends Node
class_name Command

enum Type {ATTACK, DEFEND, SKILL, ITEM}

var source : Character
var type : int
var item : Item
var priority : int

var targets = []

func _init(
	command_type : int,
	command_source : Character,
	command_item : Item = null,
	command_priority : int = 0):
	self.type = command_type
	self.source = command_source
	self.item = command_item
	self.priority = command_priority
