extends CharacterBody2D


const SPEED = 300.0

var jumped = false
var finished = false

func reset() -> void:
	position = Vector2(137.0, 516.0)
	velocity = Vector2(0.0, 0.0)

func _process(delta: float) -> void:
	# Handle restarts
	if Input.is_action_just_pressed("reset") and not finished:
		reset()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if jumped and is_on_floor():
		jumped = false
	
	# Handle jump.
	if Input.is_action_just_pressed("accept") and not jumped and not finished:
		jumped = true
		if velocity.y > 0:
			velocity.y = velocity.y * -1.3
			

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction and not finished:
		velocity.x = direction * SPEED
	elif not finished:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	reset()


func on_trophy_touched(body: Node2D) -> void:
	var camera: Camera2D = self.get_child(0)
	var particles: CPUParticles2D = self.get_child(1)
	var bubble = self.get_child(4)
	bubble.queue_free()
	particles.amount = 20
	particles.color = Color(255, 255, 255)
	finished = true
	await get_tree().create_timer(3.0).timeout # wait three seconds?
	var thankYou = Label.new()
	var thankYouSettings = LabelSettings.new()
	thankYouSettings.font_color = Color("#f2dc81")
	thankYouSettings.font_size = 40
	thankYou.text = "Thank you for playing."
	thankYou.set_position(Vector2(350.0,300.0))
	thankYou.label_settings = thankYouSettings
	for node in get_parent().get_children():
		node.queue_free()
	
	get_parent().add_child(thankYou)
	thankYou.add_child(camera)
	self.queue_free()
	
