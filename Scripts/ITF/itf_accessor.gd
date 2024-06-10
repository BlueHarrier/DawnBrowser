class_name ITFAccessor extends JSONSerializable

var buffer_view: int
var byte_offset: int = 0
var component_type: int
var normalized: bool = false
var count: int
var type: String
var accessor_max: PackedFloat32Array
var accessor_min: PackedFloat32Array
var sparse: ITFAccessorSparse
var name: String
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "bufferView": ["buffer_view", false, TYPE_INT, []],
    "byteOffset": ["byte_offset", false, TYPE_INT, []],
    "componentType": ["component_type", true, TYPE_INT, [
        5120, 5121, 5122, 5123, 5125, 5126
    ]],
    "normalized": ["normalized", false, TYPE_BOOL, []],
    "count": ["count", true, TYPE_INT, []],
    "type": ["type", true, TYPE_STRING, [
        "SCALAR", "VEC2", "VEC3", "VEC4",
        "MAT2", "MAT3", "MAT4"
    ]],
    "max": ["accessor_max", false, TYPE_ARRAY, []],
    "min": ["accessor_min", false, TYPE_ARRAY, []],
    "sparse": ["sparse", false, TYPE_OBJECT, []],
    "name": ["name", false, TYPE_STRING, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES

func _deserialize_object(_property: String, json: Dictionary) -> Error:
    sparse = ITFAccessorSparse.new()
    return sparse.deserialize(json)
