class_name LocalFile extends AsyncFile

func _load() -> void:
    var file_access: FileAccess = FileAccess.open(uri, FileAccess.READ)
    var file_error: Error = file_access.get_error()
    if file_error != OK:
        error = file_error
        return
    size = file_access.get_len()
    file_access.close()
    type = uri.get_extension().to_lower()
    name = uri.get_file()
    file_loaded.emit(uri)
