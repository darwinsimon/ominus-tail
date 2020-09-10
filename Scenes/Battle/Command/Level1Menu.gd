extends Control
class_name Level1Menu

export(String) var command_name = ""
export(bool) var enabled = true
export(bool) var selected = false

func _ready():
	$Label.text = command_name
	$Cursor.visible = selected
	
	
func set_selected(selected : bool):
	self.selected = selected
	$Cursor.visible = selected


