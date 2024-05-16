class_name _SystemManager extends Node

var ui_enabled: bool = true
var ui_control: Control
var game_rules: IsleWorldRules

# Load blank scene
func _ready() -> void:
    ui_control = $UIControl
    var blank_scene: PackedScene = load("res://Scenes/blank.tscn")
    var inst: IsleWorld = blank_scene.instantiate()
    game_rules = inst.rules
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
    return get_origin().get_node("Worlds")

# Get avatar root node
func get_avatar() -> Node:
    return get_origin().get_node("Avatars")

# Get artifacts root node
func get_artifacts() -> Node:
    return get_origin().get_node("Artifacts")

# Get origin root node
func get_origin() -> Node:
    return get_node("/root/Origin")

# Load world into scene
func load_world(scene: PackedScene) -> void:
    var node: Node = scene.instantiate()
    if !node is IsleWorld:
        node.free()
        return
    var new_world: IsleWorld = node
    var world: Node = get_world()
    for child in world.get_children():
        child.queue_free()
    get_world().add_child(new_world)
    game_rules = new_world.rules
    _UserController.transform.origin = Vector3(0, 0, 0)
