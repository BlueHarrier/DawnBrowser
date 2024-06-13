class_name ITFCameraPerspective extends JSONSerializable

var aspect_ratio: float
var yfov: float
var zfar: float
var znear: float
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "aspectRatio": ["aspect_ratio", false, TYPE_FLOAT, []],
    "yfov": ["yfov", true, TYPE_FLOAT, []],
    "zfar": ["zfar", false, TYPE_FLOAT, []],
    "znear": ["znear", true, TYPE_FLOAT, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
