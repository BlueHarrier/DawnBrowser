class_name HTTPFile extends AsyncFile

const UUID_CHARACTERS: String = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
const UUID_LENGTH: int = 32

var _request: HTTPRequest = null

func _load() -> void:
    if _request != null:
        _request.cancel_request()
        _request.queue_free()
    _request = SystemManager.create_http_request()
    _request.request_completed.connect(__on_request_completed)
    _request.request(uri)

func __on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
    _request.queue_free()
    if result != HTTPRequest.RESULT_SUCCESS or response_code != 200:
        file_error.emit(ERR_CANT_ACQUIRE_RESOURCE)
        return
    for header in headers:
        var header_split: PackedStringArray = header.split(":")
        match header_split[0]:
            "Content-Length":
                size = header_split[1].to_int()
            "Content-Type":
                var mime_type: PackedStringArray = header_split[1].split("/")
                type = mime_type[1]
                name = uri.get_file() + "." + type
    var unique_name: String = "user://temp/" + __generate_uuid() + "." + type
    var file_access: FileAccess = FileAccess.open(unique_name, FileAccess.WRITE)
    file_access.store_buffer(body)
    file_access.close()
    file_loaded.emit(unique_name)

func __generate_uuid() -> String:
    var uuid: String = ""
    for i in range(UUID_LENGTH):
        uuid += UUID_CHARACTERS[randi() % UUID_CHARACTERS.length()]
    return uuid