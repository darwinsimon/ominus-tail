extends PanelContainer
class_name HeroPanel

var hInfoSCN = preload("res://Scenes/Battle/HeroInfo.tscn")

var infos = [];

func init(heroes : Array):
	for hero in heroes:
		var heroInfo = hInfoSCN.instance()
		heroInfo.init(hero)
		infos.append(heroInfo)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in infos:
		$HeroList.add_child(i)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
