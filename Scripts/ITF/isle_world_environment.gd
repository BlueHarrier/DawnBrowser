class_name IsleWorldEnvironment extends Resource

@export var camera_z_near: float = 0.1
@export var camera_z_far: float = 1000.0
@export var fog_enabled: bool = false
@export var fog_start_distance: float = 0.0
@export var fog_end_distance: float = 100.0
@export var fog_color: Color = Color(0.5, 0.5, 0.5)
@export var ambient_light_source: AmbienLightSource = AmbienLightSource.SKYBOX
@export var ambient_light_color: Color = Color(0.5, 0.5, 0.5)
@export var ambient_light_energy: float = 1.0

enum AmbienLightSource {
    SKYBOX,
    COLOR
}

func from_json(json: Dictionary) -> Error:
    if json.has("cameraZNear"):
        if json["cameraZNear"] is float:
            camera_z_near = json["cameraZNear"]
        else: return ERR_PARSE_ERROR
    if json.has("cameraZFar"):
        if json["cameraZFar"] is float:
            camera_z_far = json["cameraZFar"]
        else: return ERR_PARSE_ERROR
    if json.has("fogEnabled"):
        if json["fogEnabled"].is_bool():
            fog_enabled = json["fogEnabled"]
        else: return ERR_PARSE_ERROR
    if json.has("fogStartDistance"):
        if json["fogStartDistance"] is float:
            fog_start_distance = json["fogStartDistance"]
        else: return ERR_PARSE_ERROR
    if json.has("fogEndDistance"):
        if json["fogEndDistance"] is float:
            fog_end_distance = json["fogEndDistance"]
        else: return ERR_PARSE_ERROR
    if json.has("fogColor"):
        if json["fogColor"] is Array:
            var arr: Array = json["fogColor"]
            fog_color = Color(arr[0], arr[1], arr[2])
        else: return ERR_PARSE_ERROR
    if json.has("ambientLightSource"):
        if !json["ambientLightSource"] is String: return ERR_PARSE_ERROR
        var light_source: String = json["ambientLightSource"]
        match light_source:
            "skybox": ambient_light_source = AmbienLightSource.SKYBOX
            "color": ambient_light_source = AmbienLightSource.COLOR
            _: return ERR_PARSE_ERROR
    if json.has("ambientLightColor"):
        if json["ambientLightColor"] is Array:
            var arr: Array = json["ambientLightColor"]
            ambient_light_color = Color(arr[0], arr[1], arr[2])
        else: return ERR_PARSE_ERROR
    if json.has("ambientLightEnergy"):
        if json["ambientLightEnergy"] is float:
            ambient_light_energy = json["ambientLightEnergy"]
        else: return ERR_PARSE_ERROR
    return OK
