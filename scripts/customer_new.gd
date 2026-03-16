extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0
var ray_collider
@export var fly = false
@onready var timer = $Timer

func _ready() -> void:
	print("Started")
	timer.start(30.0)


func _physics_process(delta: float) -> void:
	$Label2.text = "Time Left: %.2f" % timer.time_left
	if timer.time_left < 0.1:
		get_tree().reload_current_scene()
	if fly:
		velocity.y -= 1500
	if ray_collider == null:
		$Label.text = ""
	ray_collider = $RayCastContainer/RayCast2D.get_collider()
	if ray_collider != null:
		if $RayCastContainer/RayCast2D.is_colliding() and $RayCastContainer/RayCast2D.get_collider().is_in_group("breakable"):
			$Label.text = "Press E to mine bread!"
			if Input.is_action_just_pressed("pickup"):
				print("Hello mate")
				print(ray_collider)
				ray_collider.queue_free()
		else:
			$Label.text = ""
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.x == 0 and velocity.y == 0:
		$AnimatedSprite2D.play("idle")
	elif velocity.x > 0 and velocity.y == 0 or velocity.x < 0 and velocity.y == 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("jump")
		
	if velocity.x > 0:
		$RayCastContainer.scale.x = 1
		$AnimatedSprite2D.flip_h = false
	if velocity.x < 0:
		$RayCastContainer.scale.x = -1
		$AnimatedSprite2D.flip_h = true

	move_and_slide()
