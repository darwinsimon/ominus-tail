extends Node
class_name Command

enum Type {ATTACK, DEFEND, SKILL, ITEM}

var source : Character
var type : int
var item : Item

var targets = []

func _init(type : int, source : Character, item : Item = null):
	self.type = type
	self.source = source
	self.item = item
