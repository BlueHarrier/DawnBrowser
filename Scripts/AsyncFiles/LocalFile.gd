class_name LocalFile extends AsyncFile

func _load() -> void:
    var file_access: FileAccess = FileAccess.open(uri, FileAccess.READ)
    var access_error: Error = file_access.get_error()
    if access_error != OK:
        file_error.emit(access_error)
    size = file_access.get_len()
    file_access.close()
    type = uri.get_extension().to_lower()
    name = uri.get_file()
    file_loaded.emit(uri)
