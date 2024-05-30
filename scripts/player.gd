extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var just_wall_jumped = false
var air_jump = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D
func _ready() -> void:
	WorldSignals.tp_point.connect(nothing)


func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	_apply_gravity(delta)
	handle_wall_jump()
	handle_jump()
	upd_animations(direction)
	move_and_slide()
	appl_direction(direction)
	just_wall_jumped = false
	
func _apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
func handle_jump():
	if is_on_floor(): air_jump = true
	# Handle jump.
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
				velocity.y = JUMP_VELOCITY
	if not is_on_floor():
		if Input.is_action_just_pressed("jump") and air_jump and not just_wall_jumped:
			velocity.y = JUMP_VELOCITY
			air_jump = false
			
func handle_wall_jump():
	if not is_on_wall_only(): return
	var wall_normal = get_wall_normal()
	if Input.is_action_just_pressed("jump"):
		velocity.x = wall_normal.x * SPEED
		velocity.y = JUMP_VELOCITY
		just_wall_jumped = true

func upd_animations(direction):
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

func appl_direction(direction):
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
func nothing(x, y):
	self.position.x = x
	self.position.y = y
