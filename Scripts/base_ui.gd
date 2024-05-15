class_name BaseUI extends Control

var path_bar: TextEdit
var load_button: Button

func _ready() -> void:
    path_bar = $Panel/Elements/TextEdit
    load_button = $Panel/Elements/Button

    load_button.pressed.connect(on_load_button_pressed)

func on_load_button_pressed() -> void:
    var path: String = path_bar.text
    if path == "":
        return
    var path_split: PackedStringArray = path.split("#")
    var scene: Variant = null
    if path_split.size() >= 2:
        if path_split[1].is_valid_int():
            scene = path_split[1].to_int()
        else:
            scene = path_split[1]
    path = path_split[0]
    var itf: ITFDocument = ITFDocument.new()
    var error: Error = itf.open(path)
    if error != OK:
        printerr("Error loading ITF file: " + str(error))
        return
    var world_scene: PackedScene = null
    if scene:
        if scene is int:
            itf.get_world(scene)
        else:
            itf.get_world_by_name(scene)
    else:
        world_scene = itf.get_default_world()
    if world_scene == null:
        printerr("No world found in ITF file")
        return
    var system_manager: _SystemManager = SystemManager
    system_manager.load_world(world_scene)
