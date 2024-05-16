extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const jump_power = -2000.0
const acc = 50
const friction = 70
const wall_jump_pushback = 100
const wall_slide_gravity = 100
var is_wall_sliding = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

func play_movement():
	move_and_slide()
	
func accelerate(direction):
	velocity = velocity.move_toward(SPEED * direction, acc)
	
func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)

func jump():
	velocity.y += gravity
	if Input.is_action_just_pressed("move_up"):
		if is_on_floor():
			velocity.y = jump_power
		if is_on_wall() and Input.is_action_pressed("move_right"):
			velocity.y = jump_power
			velocity.x = wall_jump_pushback
		if is_on_wall() and Input.is_action_pressed("move_left"):
			velocity.y = jump_power
			velocity.x = wall_jump_pushback
func wall_slide(delta):
	if is_on_wall() and !is_on_floor():
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			is_wall_sliding = true
		else:
			is_wall_sliding = false
	else:
		is_wall_sliding = false
	
	if is_wall_sliding:
		velocity.y =+ (wall_slide_gravity * delta)
		velocity.y = min(velocity.y, wall_slide_gravity)
		
func input() -> Vector2:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("move_left", "move_right")
	input_dir = input_dir.normalized()
	return input_dir
func _physics_process(delta):
	var input_dir: Vector2 = input()
	
	if input_dir != Vector2.ZERO:
		accelerate(input_dir)
	else:
		add_friction()
	play_movement()
	jump()
	wall_slide(delta)

	# Add the gravity.


	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
