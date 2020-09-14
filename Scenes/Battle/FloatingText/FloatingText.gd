extends Position2D
class_name FloatingText

onready var tween = $Tween

var velocity : Vector2 = Vector2(rand_range(-20, 20), -70)
var gravity : Vector2 = Vector2(0, 1)

const MASS : int = 200

#######################
### Override functions
#######################

func _ready():
	
	# Fade the text after 0.7
	tween.interpolate_property(self, "modulate:a",
		modulate.a,
		0,
		0.4, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.8)
	
	# Increase text size
	tween.interpolate_property(self, "scale",
		Vector2(0.5,0.5),
		Vector2(1.0,1.0),
		0.4, Tween.TRANS_QUART, Tween.EASE_OUT)
		
	# Reduce text size
	tween.interpolate_property(self, "scale",
		Vector2(1.0,1.0),
		Vector2(0.5,0.5),
		1, Tween.TRANS_LINEAR, Tween.EASE_OUT, 1)
	
	# Destroy after 1s
	tween.interpolate_callback(self, 1, "_destroy")
	
	tween.start()

func _physics_process(delta):
	velocity += gravity * MASS * delta
	position += velocity * delta
	
	
#######################
### Public functions
#######################

func set_text(t : String) -> void:
	$Label.text = t

#######################
### Private functions
#######################
	
func _destroy() -> void:
	queue_free()
