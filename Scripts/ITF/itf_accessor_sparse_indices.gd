class_name ITFAccessorSparseIndices extends JSONSerializable

var buffer_view: int
var byte_offset: int
var component_type: int
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "bufferView": ["buffer_view", true, TYPE_INT, []],
    "byteOffset": ["byte_offset", false, TYPE_INT, []],
    "componentType": ["component_type", true, TYPE_INT, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
