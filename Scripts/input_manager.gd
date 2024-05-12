class_name _InputManager extends Node

@export var mouse_sensitivity: float = 0.2
@export var controller_sensitivity: float = 50.0

var mouse_look_axis: Vector2 = Vector2(0.0, 0.0)

signal mouse_update(mouse_movement: Vector2)

func get_movement_axis() -> Vector2:
	var x_axis: float = Input.get_axis("user_right", "user_left")
	var y_axis: float = Input.get_axis("user_forward", "user_backwards")
	var user_axis: Vector2 = Vector2(x_axis, y_axis)
	return user_axis.limit_length(1.0)

func get_look_axis() -> Vector2:
	var x_axis: float = Input.get_axis("user_look_right", "user_look_left")
	var y_axis: float = Input.get_axis("user_look_up", "user_look_down")
	return Vector2(x_axis, y_axis) * controller_sensitivity

func _input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion:
		var mouse_event: InputEventMouseMotion = event as InputEventMouseMotion
		mouse_update.emit(mouse_event.relative * mouse_sensitivity)
