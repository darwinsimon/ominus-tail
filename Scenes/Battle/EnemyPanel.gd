extends PanelContainer
class_name EnemyPanel

var eInfoSCN = preload("res://Scenes/Battle/EnemyInfo.tscn")

var infos = [];

func init(enemies : Array):
	for enemy in enemies:
		var enemyInfo = eInfoSCN.instance()
		enemyInfo.init(enemy.char_name)
		infos.append(enemyInfo)

func _ready():
	for i in infos:
		$EnemyList.add_child(i)
