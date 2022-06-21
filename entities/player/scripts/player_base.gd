extends CharacterBody3D

@export var speed := 5.0
@export var jump_strength := 5.0
@export var gravity := 9.8
@export var number_jumps := 2
@export var mouse_sensitivity := 0.001

var _current_jump := 0


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	character_movement(delta)



func character_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Reset the number of jumps on touch the floor
	if is_on_floor():
		_current_jump = 0

	# Handle Jump.		
	if Input.is_action_just_pressed("a_jump") and _current_jump < number_jumps:
		_current_jump += 1
		
		if jump_strength > velocity.y:
			velocity.y = jump_strength
			

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("a_left", "a_right", "a_up", "a_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0.0
		velocity.z = 0.0
	
	move_and_slide()


