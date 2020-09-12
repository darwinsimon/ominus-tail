extends VBoxContainer
class_name HeroInfo

export(String) var hero_name = ""
export(int) var curr_HP = 0
export(int) var curr_MP = 0

var new_HP = 0
var new_MP = 0

func init(hero : Hero):
	self.hero_name = hero.char_name
	self.curr_HP = hero.max_hp
	self.curr_MP = hero.max_mp
	self.new_HP = hero.max_hp
	self.new_MP = hero.max_mp


func _ready():

	$HSplit/HB1/CurrHP.text = str(curr_HP)
	$HSplit/HB2/CurrMP.text = str(curr_MP)
	$Name.text = hero_name
	
	new_HP = curr_HP
	new_MP = curr_MP


func set_new_hp(hp : int):
	new_HP = hp

func set_new_mp(mp : int):
	new_MP = mp
	
func _process(delta):
	
	# HP ticking animation
	if curr_HP != new_HP:
		if curr_HP > new_HP:
			curr_HP -= 1
		elif curr_HP < new_HP:
			curr_HP += 1
		
		$HSplit/HB1/CurrHP.text = str(curr_HP)

	# MP ticking animation
	if curr_MP != new_MP:
		if curr_MP > new_MP:
			curr_MP -= 1
		elif curr_MP < new_MP:
			curr_MP += 1
		
		$HSplit/HB2/CurrMP.text = str(curr_MP)

