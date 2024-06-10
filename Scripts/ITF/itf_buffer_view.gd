class_name ITFBufferView extends JSONSerializable

var buffer: int
var byte_offset: int
var byte_length: int
var byte_stride: int
var target: int
var name: String
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "buffer": ["buffer", true, TYPE_INT, []],
    "byteOffset": ["byte_offset", false, TYPE_INT, []],
    "byteLength": ["byte_length", true, TYPE_INT, []],
    "byteStride": ["byte_stride", false, TYPE_INT, []],
    "target": ["target", false, TYPE_INT, [34962, 34963]],
    "name": ["name", false, TYPE_STRING, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
