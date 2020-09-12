extends VBoxContainer
class_name EnemyInfo

export(String) var enemy_name = ""


func init(enemy : Enemy):
	self.enemy_name = enemy.char_name


func _ready():
	$Name.text = enemy_name


