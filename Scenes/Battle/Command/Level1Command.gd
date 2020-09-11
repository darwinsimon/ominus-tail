extends VBoxContainer
class_name Level1Command

signal on_selected
signal on_canceled


var l1SCN = preload("res://Scenes/Battle/Command/Level1Menu.tscn")

enum Menu {ATTACK = 0, DEFEND = 1, SKILL = 2, ITEM = 3}

var selected = Menu.ATTACK

var menus = []

#######################
### Override functions
#######################

func _ready():
	
	set_process_input(false)
	
	var menuAtk = l1SCN.instance()
	menuAtk.command_name = "Attack"
	menuAtk.set_selected(true)
	menus.append(menuAtk)
	$GridContainer.add_child(menuAtk)
	
	var menuDef = l1SCN.instance()
	menuDef.command_name = "Defend"
	menus.append(menuDef)
	$GridContainer.add_child(menuDef)
	
	var menuSkl = l1SCN.instance()
	menuSkl.command_name = "Skill"
	menus.append(menuSkl)
	$GridContainer.add_child(menuSkl)
	
	var menuItm = l1SCN.instance()
	menuItm.command_name = "Item"
	menus.append(menuItm)
	$GridContainer.add_child(menuItm)

func _input(event : InputEvent):
	if event.is_action_pressed("ui_accept"):
		emit_signal("on_selected", selected)
	elif event.is_action_pressed("ui_cancel"):
		emit_signal("on_canceled")
	else:
		var new_selected = selected
		if event.is_action_pressed("ui_right") && selected%2==0:
			new_selected += 1
		elif event.is_action_pressed("ui_left") && selected%2!=0:
			new_selected -= 1
		elif event.is_action_pressed("ui_down") && selected < Menu.SKILL:
			new_selected += 2
		elif event.is_action_pressed("ui_up") && selected > Menu.DEFEND:
			new_selected -= 2
		
		if new_selected != selected:
			selected = new_selected
			for m in range(4):
				menus[m].set_selected(new_selected == m)
				
#######################
### Public functions
#######################

func update_hero_name(hero_name : String):
	$HeroName.text = hero_name
