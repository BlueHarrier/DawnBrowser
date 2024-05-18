@tool
class_name IsleExtensions extends GLTFDocumentExtension

const SUPPORTED_EXTENSIONS: PackedStringArray = ["ISLE_world"]

func _get_supported_extensions() -> PackedStringArray:
    return SUPPORTED_EXTENSIONS

func _import_post(state: GLTFState, root: Node) -> Error:
    var scenes: Array = state.json["scenes"]
    var nodes: Array = root.get_children()
    var node_offset: int = 0
    root.name = "Root"
    for scene: Dictionary in scenes:
        var node_amount: int = scene["nodes"].size()
        if !scene.has("extensions"):
            node_offset += node_amount
            continue
        var extensions: Dictionary = scene["extensions"]
        if !extensions.has("ISLE_world"):
            node_offset += node_amount
            continue
        var isle_world: Dictionary = extensions["ISLE_world"]
        var world_node: IsleWorld = IsleWorld.new()
        if scene.has("name"):
            world_node.set_name(scene["name"])
        if world_node.from_json(isle_world) != OK:
            return ERR_PARSE_ERROR
        while node_amount > 0:
            var node: Node = nodes[node_offset]
            node.get_parent().remove_child(node)
            world_node.add_child(node)
            node_amount -= 1
            node_offset += 1
        root.add_child(world_node)
        __reset_ownership(world_node, world_node)
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

func __reset_ownership(node: Node, owner: Node) -> void:
    if node != owner:
        node.owner = owner
    for child in node.get_children():
        __reset_ownership(child, owner)
