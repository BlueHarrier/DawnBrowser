class_name ITFAnimationChannelTarget extends JSONSerializable

var node: int
var path: String
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "node": ["node", true, TYPE_INT, []],
    "path": ["path", true, TYPE_STRING, [
        "translation", "rotation", "scale", "weights"
    ]],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
