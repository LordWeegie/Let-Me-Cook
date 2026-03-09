extends CharacterBody2D

const SPEED = 400

var carrying_food = false
var carrying_baguette = false
var carrying_coffee = false

var item_carried

func _get_input():
	var direction = Input.get_vector("left", "right", "down", "up")
	velocity = direction * SPEED
	# Flip player as they move
	if velocity.y > 0 or velocity.x > 0 or velocity.y < 0 or velocity.x < 0:
		$AnimatedSprite2D.rotation = atan2(velocity.x, velocity.y)
		
	if velocity.x > 0 or Input.is_action_pressed("right"):
		$RayCast2D.rotation_degrees = -90
	if velocity.x < 0 or Input.is_action_pressed("left"):
		$RayCast2D.rotation_degrees = 90
	if velocity.y > 0 or Input.is_action_pressed("down"):
		$RayCast2D.rotation_degrees = 0
	if velocity.y < 0 or Input.is_action_pressed("up"):
		$RayCast2D.rotation_degrees = 180
		
	_get_input()
	move_and_slide()

func _pickup():
	if carrying_baguette:
		$Lable1.Text = "baguette aquired"
	else:
		$Lable1.Text = "obtained none"
	
	if carrying_coffee:
		$Lable1.Text = "carrying coffee"
	else:
		$Lable1.text = "obtained none"
	
	if not carrying_food:
		$Lable1.text = "obtained none"
