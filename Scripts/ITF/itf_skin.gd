class_name ITFSkin extends JSONSerializable

var inverse_bind_matrices: int
var skeleton: int
var joints: PackedInt32Array
var name: String
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "inverseBindMatrices": ["inverse_bind_matrices", false, TYPE_INT, []],
    "skeleton": ["skeleton", false, TYPE_INT, []],
    "joints": ["joints", true, TYPE_ARRAY, []],
    "name": ["name", false, TYPE_STRING, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
