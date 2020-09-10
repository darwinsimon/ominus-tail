extends Node2D


var frames : SpriteFrames

func init(frames : SpriteFrames):
	print(frames)
	self.frames = frames
	
func _ready():
	#print(frames.has_animation("idle"))
	$ASprite.frames = frames
	$ASprite.animation = "idle"
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
