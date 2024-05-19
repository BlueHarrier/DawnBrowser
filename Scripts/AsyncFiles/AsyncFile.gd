class_name AsyncFile extends Resource

var uri: String
var type: String
var size: int
var name: String
var error: Error

signal file_loaded(local_path: String)

func _init(new_uri: String) -> void:
    uri = new_uri

func _load() -> void:
    pass

func load() -> void:
    _load()
