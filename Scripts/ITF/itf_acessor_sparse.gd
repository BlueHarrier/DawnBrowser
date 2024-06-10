class_name ITFAccessorSparse extends JSONSerializable

var count: int
var indices: ITFAccessorSparseIndices
var values: ITFAccessorSparseValues
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "count": ["count", true, TYPE_INT, []],
    "indices": ["indices", true, TYPE_OBJECT, []],
    "values": ["values", true, TYPE_OBJECT, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES

func _deserialize_object(property: String, json: Dictionary) -> Error:
    match property:
        "indices":
            indices = ITFAccessorSparseIndices.new()
            return indices.deserialize(json)
        "values":
            values = ITFAccessorSparseValues.new()
            return values.deserialize(json)
    return ERR_INVALID_DATA
