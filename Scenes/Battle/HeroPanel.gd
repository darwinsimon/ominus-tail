extends PanelContainer
class_name HeroPanel

var infos = [];

func init(heroes : Array):
	infos = heroes

func _ready():
	for i in infos:
		$HeroList.add_child(i)
