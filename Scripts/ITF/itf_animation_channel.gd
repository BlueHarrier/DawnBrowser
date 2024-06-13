class_name ITFAnimationChannel extends JSONSerializable

var sampler: int
var target: ITFAnimationChannelTarget
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "sampler": ["sampler", true, TYPE_INT, []],
    "target": ["target", true, TYPE_OBJECT, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES

func _deserialize_object(property: String, json: Dictionary) -> Error:
    match property:
        "target":
            target = ITFAnimationChannelTarget.new()
            return target.deserialize(json)
    return ERR_INVALID_DATA

