class_name ITFAnimation extends JSONSerializable

var channels: Array[ITFAnimationChannel] = []
var samplers: Array[ITFAnimationSampler] = []
var name: String
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "channels": ["channels", true, TYPE_ARRAY, []],
    "samplers": ["samplers", true, TYPE_ARRAY, []],
    "name": ["name", false, TYPE_STRING, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES

func _deserialize_object(property: String, json: Dictionary) -> Error:
    match property:
        "channels":
            var channel: ITFAnimationChannel = ITFAnimationChannel.new()
            return channel.deserialize(json)
        "samplers":
            var sampler: ITFAnimationSampler = ITFAnimationSampler.new()
            return sampler.deserialize(json)
    return ERR_INVALID_DATA
