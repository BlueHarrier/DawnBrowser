class_name ITFBuffer extends JSONSerializable

var uri : String
var byte_length: int
var name: String
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "uri": ["uri", false, TYPE_STRING, []],
    "byteLength": ["byte_length", true, TYPE_INT, []],
    "name": ["name", false, TYPE_STRING, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
