extends CharacterBody3D

@export var mouse_sensitivity = 0.001
@export var run_speed = 40
@export var walk_speed = 30
@export var FRICTION = 1
var SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x, -1.2, 1.2)

func _physics_process(delta):
	# Add the gravity.
	if Input.is_action_pressed("Run"):
		SPEED = run_speed
	else:
		SPEED = walk_speed

	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, FRICTION)
		velocity.z = move_toward(velocity.z, direction.z * SPEED, FRICTION)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)
		velocity.z = move_toward(velocity.z, 0, FRICTION)

	move_and_slide()
	
func process_input(delta):
	if Input.is_action_pressed("toggle_flashlight"):
		$SpotLight3D.visable = not $SpotLight3D.visble 
	

