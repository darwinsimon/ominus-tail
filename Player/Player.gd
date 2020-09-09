extends KinematicBody2D

class_name Player

var speed = 200
var motion = Vector2(0, 0)
var interact_target : Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if interact_target != null && Input.is_action_just_pressed("interact"):
		interact_target.interact()

func _physics_process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	if Input.is_action_pressed("ui_down"):
		velocity.y = speed
	if Input.is_action_pressed("ui_up"):
		velocity.y = -speed
	
	if velocity.x != 0 || velocity.y != 0:
		$AnimatedSprite.animation = "walk"
		if velocity.x != 0:
			$AnimatedSprite.flip_v = false
			$AnimatedSprite.flip_h = velocity.x < 0
		move_and_slide(velocity)
	else:
		$AnimatedSprite.animation = "idle"
	
	$AnimatedSprite.play()
	
		


func _on_InteractableArea_body_entered(body: Node):
	if(body.has_method("can_interact")):
		interact_target = body


func _on_InteractableArea_body_exited(body: Node):
	if(body.has_method("can_interact")):
		interact_target = null
