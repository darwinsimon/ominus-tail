extends PanelContainer
class_name HeroPanel

var hInfoSCN = preload("res://Scenes/Battle/HeroInfo.tscn")

var infos = [];

func init(heroes : Array):
	for hero in heroes:
		var heroInfo = hInfoSCN.instance()
		heroInfo.init(hero)
		infos.append(heroInfo)

func _ready():
	for i in infos:
		$HeroList.add_child(i)
