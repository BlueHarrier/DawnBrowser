class_name ITFMeshPrimitive extends JSONSerializable

var attributes: Dictionary
var indices: int
var material: int
var mode: int = 4
var targets: Array
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "attributes": ["attributes", true, TYPE_DICTIONARY, []],
    "indices": ["indices", false, TYPE_INT, []],
    "material": ["material", false, TYPE_INT, []],
    "mode": ["mode", false, TYPE_INT, [
        0, 1, 2, 3, 4, 5, 6
    ]],
    "targets": ["targets", false, TYPE_ARRAY, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
