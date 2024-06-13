class_name ITFCamera extends JSONSerializable

var orthographic: ITFCameraOrthographic
var perspective: ITFCameraPerspective
var type: String
var name: String
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "orthographic": ["orthographic", false, TYPE_DICTIONARY, []],
    "perspective": ["perspective", false, TYPE_DICTIONARY, []],
    "type": ["type", true, TYPE_STRING, ["perspective", "orthographic"]],
    "name": ["name", false, TYPE_STRING, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES

func _deserialize_object(property: String, json: Dictionary) -> Error:
    match property:
        "orthographic":
            orthographic = ITFCameraOrthographic.new()
            return orthographic.deserialize(json)
        "perspective":
            perspective = ITFCameraPerspective.new()
            return perspective.deserialize(json)
    return ERR_INVALID_DATA
