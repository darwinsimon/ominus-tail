extends VBoxContainer

class_name EnemyInfo

export(String) var enemy_name = ""


func init(enemy_name : String):
	self.enemy_name = enemy_name


func _ready():
	$Name.text = enemy_name


