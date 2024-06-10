class_name ITFAccessorSparseValues extends JSONSerializable

var buffer_view: int
var byte_offset: int
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "bufferView": ["buffer_view", true, TYPE_INT, []],
    "byteOffset": ["byte_offset", true, TYPE_INT, []],
    "extensions": ["extensions", true, TYPE_DICTIONARY, []],
    "extras": ["extras", true, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
