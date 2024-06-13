class_name ITFCameraOrthographic extends JSONSerializable

var xmag: float
var ymag: float
var zfar: float
var znear: float
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "xmag": ["xmag", true, TYPE_FLOAT, []],
    "ymag": ["ymag", true, TYPE_FLOAT, []],
    "zfar": ["zfar", true, TYPE_FLOAT, []],
    "znear": ["znear", true, TYPE_FLOAT, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
