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
    load_button.disabled = true
    var file: AsyncFile = LocalFile.new(path)
    file.bind_signals(load_gltf, load_error)
    file.load()

func load_gltf(path: String) -> void:
    var itf: ITFDocument = ITFDocument.new()
    var error: Error = itf.open(path)
    if error != OK:
        printerr("Error loading ITF file: " + str(error))
        return
    var world_scene: PackedScene = itf.get_default_world()
    if world_scene == null:
        printerr("No world found in ITF file")
        return
    var system_manager: _SystemManager = SystemManager
    system_manager.load_world(world_scene)
    load_button.disabled = false

func load_error(error: Error) -> void:
    printerr("Error loading file: " + str(error))
    load_button.disabled = false
