@tool
class_name ITFEditorExport extends EditorScript

static var _extension: IsleExtensions = null

static func register() -> void:
    if _extension == null:
        _extension = IsleExtensions.new()
        GLTFDocument.register_gltf_document_extension(_extension)
