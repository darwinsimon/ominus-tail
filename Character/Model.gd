extends Node2D
class_name Model

enum Side { LEFT, RIGHT }

var frames : SpriteFrames
var selected : bool = false
var side : int = Side.LEFT


#######################
### Override functions
#######################

func _ready():
	$Container/ASprite.frames = frames
	$Container/ASprite.animation = "idle"
	
	if side == Side.RIGHT:
		$Container/Selector.position = Vector2($Container/Selector.position.x + 100, $Container/Selector.position.y)



#######################
### Public functions
#######################

func init(frames : SpriteFrames, side : int = Side.LEFT):
	self.frames = frames
	self.side = side
	

func set_selected(selected : bool) -> void:
	self.selected = selected
	$Container/Selector.visible = selected
