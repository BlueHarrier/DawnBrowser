class_name IsleWorldPhysics extends Resource

@export var gravity: Vector3 = Vector3(0, -9.8, 0)
@export var air_thickness: float = 1.0
@export var wind_force: Vector3 = Vector3(0, 0, 0)

func from_json(json: Dictionary) -> Error:
    if json.has("gravity"):
        if json["gravity"] is Array:
            var arr: Array = json["gravity"]
            gravity = Vector3(arr[0], arr[1], arr[2])
        else: return ERR_PARSE_ERROR
    if json.has("air_thickness"):
        if json["air_thickness"] is float:
            air_thickness = json["air_thickness"]
        else: return ERR_PARSE_ERROR
    if json.has("wind_force"):
        if json["wind_force"] is Array:
            var arr: Array = json["wind_force"]
            wind_force = Vector3(arr[0], arr[1], arr[2])
        else: return ERR_PARSE_ERROR
    return OK
