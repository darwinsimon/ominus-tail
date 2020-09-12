extends PanelContainer
class_name EnemyPanel

var infos = [];

func init(enemies : Array):
	infos = enemies

func _ready():
	for i in infos:
		$EnemyList.add_child(i)
