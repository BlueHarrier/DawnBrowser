class_name ITFDocument extends Resource

var _default_world: int = -1
var _world_list: Array[PackedScene] = []
var _world_dict: Dictionary = {}

func open(file_path: String) -> Error:
    _default_world = -1
    _world_list.clear()
    _world_dict.clear()
    var loader: GLTFDocument = GLTFDocument.new()
    var state: GLTFState = GLTFState.new()
    var extension: IsleExtensions = IsleExtensions.new()
    GLTFDocument.register_gltf_document_extension(extension)
    var load_error: Error = loader.append_from_file(file_path, state)
    GLTFDocument.unregister_gltf_document_extension(extension)
    if load_error != OK:
        return load_error
    var json: Dictionary = state.get_json()
    if json.has("scene"):
        _default_world = json["scene"]
    else:
        _default_world = 0
    var root: Node3D = loader.generate_scene(state)
    var packed_scene: PackedScene = PackedScene.new()
    packed_scene.pack(root)
    add_world(packed_scene, root.name)
    return OK

func get_world_number() -> int:
    return _world_list.size()

func get_world(index: int) -> PackedScene:
    if index >= 0 and index < _world_list.size():
        return _world_list[index]
    return null

func get_world_by_name(name: String) -> PackedScene:
    if _world_dict.has(name):
        return _world_dict[name]
    return null

func get_default_world() -> PackedScene:
    if _default_world >= 0 and _default_world < _world_list.size():
        return _world_list[_default_world]
    return null

func add_world(scene: PackedScene, name: String) -> int:
    _world_list.append(scene)
    _world_dict[name] = scene
    return _world_list.size() - 1

func set_default_world(index: int) -> void:
    if index >= 0 and index < _world_list.size():
        _default_world = index
