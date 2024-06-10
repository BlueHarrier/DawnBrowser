class_name ITFTextureInfo extends JSONSerializable

var index: int
var tex_coord: int = 0
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "index": ["index", true, TYPE_INT, []],
    "texCoord": ["tex_coord", false, TYPE_INT, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
