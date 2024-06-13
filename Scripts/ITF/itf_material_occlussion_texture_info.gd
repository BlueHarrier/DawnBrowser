class_name ITFMaterialOcclussionTextureInfo extends JSONSerializable

var index: int
var tex_coord: int = 0
var strength: float = 1
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "index": ["index", true, TYPE_INT, []],
    "texCoord": ["tex_coord", false, TYPE_INT, []],
    "strength": ["strength", false, TYPE_FLOAT, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
