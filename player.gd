extends CharacterBody2D


const SPEED = 300.0

func _process(delta: float) -> void:
	# Handle restarts?
	if Input.is_action_just_pressed("reset"):
		position = Vector2(0.0, 0.0)
		velocity = Vector2(0.0, 0.0)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("accept"):
		if velocity.y > 0:
			velocity.y = velocity.y * -1.3

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)

	move_and_slide()
