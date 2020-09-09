extends Control


export(String) var hero_name = ""
export(int) var curr_HP = 0
export(int) var curr_MP = 0

var new_HP = 0
var new_MP = 0


func _ready():
	$Name.text = hero_name
	$HSplit/HB1/CurrHP.text = str(curr_HP)
	$HSplit/HB2/CurrMP.text = str(curr_MP)
	
	new_HP = curr_HP
	new_MP = curr_MP


func set_new_hp(hp : int):
	curr_HP = hp

func set_new_mp(mp : int):
	curr_MP = mp
	
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

