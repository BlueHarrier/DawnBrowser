class_name _SystemManager extends Node

var ui_enabled: bool = true
var ui_control: Control

# Load blank scene
func _ready() -> void:
	var blank_scene: PackedScene = load("res://Scenes/blank.tscn")
	var inst: Node = blank_scene.instantiate()
	get_world().add_child(inst)
	ui_control = $UIControl
	toggle_menu(true)

# Checks for the escape key and the camera movement
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("user_menu"):
		toggle_menu()

# Toggles the menu on and off
func toggle_menu(enabled: bool = !ui_enabled) -> void:
	ui_enabled = enabled
	ui_control.visible = ui_enabled
	if ui_enabled:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Get world root node
func get_world() -> Node:
	return get_node("/root/Origin/World")

# Get avatar root node
func get_avatar() -> Node:
	return get_node("/root/Origin/Avatar")

# Get artifacts root node
func get_artifacts() -> Node:
	return get_node("/root/Origin/Artifacts")
