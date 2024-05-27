@tool
class_name IsleExtensions extends GLTFDocumentExtension

const SUPPORTED_EXTENSIONS: PackedStringArray = ["ISLE_world"]

func _get_supported_extensions() -> PackedStringArray:
    return SUPPORTED_EXTENSIONS

func _import_post(state: GLTFState, root: Node) -> Error:
    var scenes: Array = state.json["scenes"]
    if scenes.size() < 1:
        return ERR_FILE_UNRECOGNIZED
    var scene: Dictionary = scenes[0]
    if !scene.has("extensions"):
        return ERR_FILE_UNRECOGNIZED
    var extension: Dictionary = scene["extensions"]
    if !extension.has("ISLE_world"):
        return ERR_FILE_UNRECOGNIZED
    var world_json: Dictionary = extension["ISLE_world"]
    root.set_script(IsleWorld)
    root.from_json(world_json)
    return OK

func _export_preflight(state: GLTFState, root: Node) -> Error:
    if !root is IsleWorld:
        return ERR_FILE_UNRECOGNIZED
    var extension: Dictionary = root.to_json()
    state.set_additional_data("ISLE_world", extension)
    state.add_used_extension("ISLE_world", true)
    state.scene_name = root.name
    return OK

func _export_post(state: GLTFState) -> Error:
    var extension: Dictionary = state.get_additional_data("ISLE_world")
    var json: Dictionary = state.json
    if !json.has("scenes"):
        return ERR_FILE_UNRECOGNIZED
    var scenes: Array = json["scenes"]
    if scenes.size() < 1:
        return ERR_FILE_UNRECOGNIZED
    var scene: Dictionary = scenes[0]
    if !scene.has("extensions"):
        scene["extensions"] = {}
    scene["extensions"]["ISLE_world"] = extension
    return OK
