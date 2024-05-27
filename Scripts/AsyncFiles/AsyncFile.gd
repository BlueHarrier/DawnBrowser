class_name AsyncFile extends Resource

var uri: String
var type: String
var size: int
var name: String

signal file_loaded(local_path: String)
signal file_error(error: Error)

func _init(new_uri: String) -> void:
    uri = new_uri

func _load() -> void:
    pass

func load() -> void:
    _load()

func bind_signals(on_loaded: Callable, on_error: Callable) -> void:
    file_loaded.connect(on_loaded)
    file_error.connect(on_error)

static func from_protocol(new_uri: String) -> AsyncFile:
    var protocol: String = new_uri.substr(0, new_uri.find(":"))
    match protocol:
        "http", "https":
            return HTTPFile.new(new_uri)
        _:
            if protocol == "file":
                new_uri = new_uri.substr(7)
            return LocalFile.new(new_uri)