class_name ITFSampler extends JSONSerializable

var mag_filter: int
var min_filter: int
var wrap_s: int = 10497
var wrap_t: int = 10497
var name: String
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "magFilter": ["mag_filter", false, TYPE_INT, [9728, 9729]],
    "minFilter": ["min_filter", false, TYPE_INT, [9728, 9729, 9984, 9985, 9986, 9987]],
    "wrapS": ["wrap_s", false, TYPE_INT, [33071, 33648, 10497]],
    "wrapT": ["wrap_t", false, TYPE_INT, [33071, 33648, 10497]],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
