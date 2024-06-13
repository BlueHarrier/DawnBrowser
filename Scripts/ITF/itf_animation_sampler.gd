class_name ITFAnimationSampler extends JSONSerializable

var input: int
var interpolation: String = "LINEAR"
var output: int
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "input": ["input", true, TYPE_INT, []],
    "interpolation": ["interpolation", false, TYPE_STRING, [
        "LINEAR", "STEP", "CUBICSPLINE"
    ]],
    "output": ["output", true, TYPE_INT, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
