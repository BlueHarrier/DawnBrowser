class_name IsleWorld extends Node3D

@export var world_name: String
@export var author: String
@export var version: String
@export var tags: PackedStringArray = []
@export var rules: IsleWorldRules
@export var physics: IsleWorldPhysics
@export var environment: IsleWorldEnvironment

func _ready() -> void:
    if !rules:
        rules = IsleWorldRules.new()
    if !physics:
        physics = IsleWorldPhysics.new()
    if !environment:
        environment = IsleWorldEnvironment.new()

func from_json(json: Dictionary) -> Error:
    if json.has("name") and json["name"] is String:
        world_name = json["name"]
    else: return ERR_PARSE_ERROR
    if json.has("author") and json["author"] is String:
        author = json["author"]
    else: return ERR_PARSE_ERROR
    if json.has("version") and json["version"] is String:
        version = json["version"]
    else: return ERR_PARSE_ERROR
    if json.has("tags"):
        if json["tags"] is Array:
            tags = json["tags"]
        else: return ERR_PARSE_ERROR
    rules = IsleWorldRules.new()
    if json.has("rules"):
        if rules.from_json(json["rules"]) != OK: return ERR_PARSE_ERROR
    physics = IsleWorldPhysics.new()
    if json.has("physics"):
        if physics.from_json(json["physics"]) != OK: return ERR_PARSE_ERROR
    environment = IsleWorldEnvironment.new()
    if json.has("environment"):
        if environment.from_json(json["environment"]) != OK: return ERR_PARSE_ERROR
    return OK

func to_json() -> Dictionary:
    var json: Dictionary = {
        "name": world_name,
        "author": author,
        "version": version,
        "tags": tags
    }
    if rules:
        json["rules"] = rules.to_json()
    if physics:
        json["physics"] = physics.to_json()
    if environment:
        json["environment"] = environment.to_json()
    return json