class_name JSONSerializable extends RefCounted

var warnings: Array[Error]

# Property map format:
# {
#     "property_name": ["real_property_name", mandatory, expected_type, [validation]]
# }
func _get_property_map() -> Dictionary:
    return {}

func _deserialize_object(_property: String, _json: Dictionary) -> Error:
    return OK

func get_property_map() -> Dictionary:
    return _get_property_map()

func deserialize_object(property: String, json: Dictionary) -> Error:
    return _deserialize_object(property, json)

func set_property(property: String, value: Variant) -> Error:
    var properties: Dictionary = get_property_map()
    if !property in properties:
        warnings.push_back(ERR_DOES_NOT_EXIST)
    var property_data: Array = properties[property]
    var expected_type: int = property_data[2]
    var type: int = typeof(value)
    if type == TYPE_DICTIONARY and expected_type == TYPE_OBJECT:
        return deserialize_object(property, value)
    if type == TYPE_FLOAT and expected_type == TYPE_INT:
        value = int(value)
        type = TYPE_INT
    if expected_type != type:
        return ERR_INVALID_PARAMETER
    var validation: Array = property_data[3]
    if validation.size() > 0:
        if !value in validation:
            return ERR_INVALID_PARAMETER
    var real_property_name: String = property_data[0]
    set(real_property_name, value)
    return OK

func get_mandatory_properties() -> PackedStringArray:
    var properties: Dictionary = get_property_map()
    var mandatory_properties: PackedStringArray = []
    for property: String in properties.keys():
        if properties[property][1]:
            mandatory_properties.push_back(property)
    return mandatory_properties

func deserialize(json: Dictionary) -> Error:
    var keys: Array = json.keys()
    var mandatory_properties: PackedStringArray = get_mandatory_properties()
    for property: String in mandatory_properties:
        if !property in keys:
            return ERR_DOES_NOT_EXIST
    for property: String in keys:
        var error: Error = set_property(property, json[property])
        if error != OK:
            return error
    return OK
