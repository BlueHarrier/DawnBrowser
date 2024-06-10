class_name ITFAsset extends JSONSerializable

var copyright: String
var generator: String
var version: String
var min_version: String
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "copyright": ["copyright", false, TYPE_STRING, []],
    "generator": ["generator", false, TYPE_STRING, []],
    "version": ["version", true, TYPE_STRING, []],
    "minVersion": ["min_version", false, TYPE_STRING, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
