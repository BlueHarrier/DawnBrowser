class_name ITFMesh extends JSONSerializable

var primitives: Array[ITFMeshPrimitive] = []
var weights: PackedFloat32Array = []
var name: String = ""
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "primitives": ["primitives", true, TYPE_ARRAY, []],
    "weights": ["weights", false, TYPE_ARRAY, []],
    "name": ["name", false, TYPE_STRING, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
