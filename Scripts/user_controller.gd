class_name UserController extends CharacterBody3D

var camera: Camera3D
var camera_assistant: Node3D

func _ready() -> void:
	camera_assistant = get_node("CameraAssist")
	camera = get_node("CameraAssist/Camera3D")

# Camera rotation
func _process(delta: float) -> void:
	# Skip if the menu is open
	var system_manager: _SystemManager = SystemManager
	if system_manager.ui_enabled: return
	var x_axis: float = Input.get_axis("user_look_right", "user_look_left")
	var y_axis: float = Input.get_axis("user_look_up", "user_look_down")
	var input_manager: _InputManager = InputManager
	var total_rotation: Vector2 = Vector2(x_axis, y_axis) * input_manager.controller_sensitivity * delta
	__camera_rotate(total_rotation)

# Movement
func _physics_process(delta: float) -> void:
	# Get parameters
	var system_manager: _SystemManager = SystemManager
	var acceleration: float = 30.0 * delta
	var deacceleration: float = 40.0 * delta
	var gravity: float = -9.8 * delta
	var jump_speed: float = 2.5
	var max_speed: float = 4.0
	var max_falling_speed: float = 20.0
	
	# Input and horizontal speed receive
	var movement_axis: Vector2 = __get_movement_axis() if !system_manager.ui_enabled else Vector2()
	var cam_basis: Basis = camera_assistant.basis
	var push_input: Vector3 = cam_basis.x * movement_axis.x + cam_basis.z * movement_axis.y
	var horizontal_velocity: Vector3 = velocity
	horizontal_velocity.y = 0.0
	
	# Horizontal movement calculation
	var walk: bool = Input.is_action_pressed("user_walk")
	var target_velocity: Vector3 = push_input * max_speed * (0.5 if walk else 1.0)
	var current_to_target: Vector3 = target_velocity - horizontal_velocity
	var n_current_to_target: Vector3 = current_to_target.normalized()
	var current_to_center: Vector3 = -horizontal_velocity
	var deaccel_factor: float = n_current_to_target.dot(current_to_center.normalized())
	deaccel_factor = (deaccel_factor + 1.0) / 2.0
	var impulse: float = lerp(acceleration, deacceleration, deaccel_factor)
	var add_velocity: Vector3 = n_current_to_target * impulse
	if current_to_target.length() < add_velocity.length():
		horizontal_velocity = target_velocity
	else:
		horizontal_velocity += add_velocity
	velocity.x = horizontal_velocity.x
	velocity.z = horizontal_velocity.z
	
	# Gravity and jumping
	if !is_on_floor():
		velocity.y += gravity
		velocity.y = clamp(velocity.y, -max_falling_speed, max_falling_speed)
	else:
		if !system_manager.ui_enabled and Input.is_action_just_pressed("user_jump"):
			velocity.y = jump_speed
	
	# Execute movement
	move_and_slide()

# Mouse movement
func _input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion:
		var mouse_event: InputEventMouseMotion = event as InputEventMouseMotion
		var input_manager: _InputManager = InputManager
		var mouse_movement: Vector2 = mouse_event.relative * input_manager.mouse_sensitivity
		mouse_movement.x = -mouse_movement.x
		__camera_rotate(mouse_movement)

# Take movement axis
func __get_movement_axis() -> Vector2:
	var x_axis: float = -Input.get_axis("user_right", "user_left")
	var y_axis: float = Input.get_axis("user_forward", "user_backwards")
	var user_axis: Vector2 = Vector2(x_axis, y_axis)
	return user_axis.limit_length(1.0)

# Manage camera rotation
func __camera_rotate(cam_rotation: Vector2) -> void:
	camera.rotation_degrees.x += -cam_rotation.y
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -89, 89)
	camera_assistant.rotation_degrees.y += cam_rotation.x
	camera_assistant.rotation_degrees.y = fmod(camera_assistant.rotation_degrees.y, 360.0)
