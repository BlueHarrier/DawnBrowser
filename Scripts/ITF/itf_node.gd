class_name ITFNode extends JSONSerializable

var camera: int
var children: PackedInt32Array
var skin: int
var matrix: PackedFloat32Array = [1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1]
var mesh: int
var rotation: PackedFloat32Array = [0,0,0,1]
var scale: PackedFloat32Array = [1,1,1]
var translation: PackedFloat32Array = [0,0,0]
var weights: PackedFloat32Array
var name: String
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "camera": ["camera", false, TYPE_INT, []],
    "children": ["children", false, TYPE_ARRAY, []],
    "skin": ["skin", false, TYPE_INT, []],
    "matrix": ["matrix", false, TYPE_ARRAY, []],
    "mesh": ["mesh", false, TYPE_INT, []],
    "rotation": ["rotation", false, TYPE_ARRAY, []],
    "scale": ["scale", false, TYPE_ARRAY, []],
    "translation": ["translation", false, TYPE_ARRAY, []],
    "weights": ["weights", false, TYPE_ARRAY, []],
    "name": ["name", false, TYPE_STRING, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
