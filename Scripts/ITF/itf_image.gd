class_name ITFImage extends JSONSerializable

var uri: String
var mime_type: String
var buffer_view: int
var name: String
var extensions: Object
var extras: Object

const PROPERTIES: Dictionary = {
    "uri": ["uri", false, TYPE_STRING, ""],
    "mimeType": ["mime_type", false, TYPE_STRING, ""],
    "bufferView": ["buffer_view", false, TYPE_INT, 0],
    "name": ["name", false, TYPE_STRING, ""],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
