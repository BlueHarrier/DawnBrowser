class_name IsleWorldRules extends Resource

@export var user_gravity: Vector3 = Vector3(0.0, -9.8, 0.0)
@export var user_acceleration: float = 30.0
@export var user_deacceleration: float = 40.0
@export var user_max_velocity: float = 4.0
@export var user_jump_speed: float = 2.5
@export var user_max_fall_speed: float = 20.0
@export var user_allow_velocity_scaling: bool = true
@export var user_respawn_fall_distance: float = 30.0
@export var user_spawn_policy: RespawnPolicy = RespawnPolicy.RANDOM
@export var user_spawners: PackedVector3Array = [Vector3(0, 0, 0)]

enum RespawnPolicy {
    RANDOM,
    ORDERED
}

func from_json(json: Dictionary) -> Error:
    if json.has("userGravity"):
        if json["userGravity"] is Array:
            var arr: Array = json["userGravity"]
            user_gravity = Vector3(arr[0], arr[1], arr[2])
        else: return ERR_PARSE_ERROR
    if json.has("userAcceleration"):
        if json["userAcceleration"] is float:
            user_acceleration = json["userAcceleration"]
        else:
            return ERR_PARSE_ERROR
    if json.has("userDeceleration"):
        if json["userDeceleration"] is float:
            user_deacceleration = json["userDeceleration"]
        else:
            return ERR_PARSE_ERROR
    if json.has("userMaxVelocity"):
        if json["userMaxVelocity"] is float:
            user_max_velocity = json["userMaxVelocity"]
        else:
            return ERR_PARSE_ERROR
    if json.has("userJumpSpeed"):
        if json["userJumpSpeed"] is float:
            user_jump_speed = json["userJumpSpeed"]
        else:
            return ERR_PARSE_ERROR
    if json.has("userMaxFallSpeed"):
        if json["userMaxFallSpeed"] is float:
            user_max_fall_speed = json["userMaxFallSpeed"]
        else:
            return ERR_PARSE_ERROR
    if json.has("userAllowVelocityScaling"):
        if json["userAllowVelocityScaling"] is bool:
            user_allow_velocity_scaling = json["userAllowVelocityScaling"]
        else:
            return ERR_PARSE_ERROR
    if json.has("userRespawnFallDistance"):
        if json["userRespawnFallDistance"] is float:
            user_respawn_fall_distance = json["userRespawnFallDistance"]
        else:
            return ERR_PARSE_ERROR
    if json.has("userSpawnPolicy"):
        if !json["userSpawnPolicy"] is String: return ERR_PARSE_ERROR
        var spawn_policy: String = json["userSpawnPolicy"]
        match spawn_policy:
            "RANDOM": user_spawn_policy = RespawnPolicy.RANDOM
            "ORDERED": user_spawn_policy = RespawnPolicy.ORDERED
            _: return ERR_PARSE_ERROR
    if json.has("userSpawners"):
        if !json["userSpawners"] is Array: return ERR_PARSE_ERROR
        user_spawners.resize(0)
        for spawner: Array in json["userSpawners"]:
            user_spawners.push_back(Vector3(spawner[0], spawner[1], spawner[2]))
    return OK

func to_json() -> Dictionary:
    var json: Dictionary = {
        "userGravity": [user_gravity.x, user_gravity.y, user_gravity.z],
        "userAcceleration": user_acceleration,
        "userDeceleration": user_deacceleration,
        "userMaxVelocity": user_max_velocity,
        "userJumpSpeed": user_jump_speed,
        "userMaxFallSpeed": user_max_fall_speed,
        "userAllowVelocityScaling": user_allow_velocity_scaling,
        "userRespawnFallDistance": user_respawn_fall_distance,
        "userSpawnPolicy": __spawn_policy_str(),
        "userSpawners": []
    }
    for spawner: Vector3 in user_spawners:
        json["userSpawners"].append([spawner.x, spawner.y, spawner.z])
    return json

func __spawn_policy_str() -> String:
    match user_spawn_policy:
        RespawnPolicy.RANDOM: return "RANDOM"
        RespawnPolicy.ORDERED: return "ORDERED"
        _: return "Unknown"
