class_name ITFTexture extends JSONSerializable

var sampler: int
var source: int
var name: String
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "sampler": ["sampler", false, TYPE_INT, []],
    "source": ["source", false, TYPE_INT, []],
    "name": ["name", false, TYPE_STRING, ""],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
