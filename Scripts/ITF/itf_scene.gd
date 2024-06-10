class_name ITFScene extends JSONSerializable

var nodes: PackedInt32Array
var name: String
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "nodes": ["nodes", false, TYPE_ARRAY, TYPE_INT, []],
    "name": ["name", false, TYPE_STRING, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
