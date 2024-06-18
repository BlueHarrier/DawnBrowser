class_name BaseUI extends Control

var path_bar: TextEdit
var load_button: Button

func _ready() -> void:
	path_bar = $Panel/Elements/TextEdit
	load_button = $Panel/Elements/Button

	load_button.pressed.connect(on_load_button_pressed)

func on_load_button_pressed() -> void:
	var path: String = path_bar.text
	if path == "":
		return
	load_button.disabled = true
	var file: AsyncFile = AsyncFile.from_protocol(path)
	file.bind_signals(load_gltf, load_error)
	file.load()

func load_gltf(path: String) -> void:
	const MAPPING: Dictionary = {
		"ITFAccessor": {
			"min": "accessor_min",
			"max": "accessor_max",
		}
	}
	var file_access: FileAccess = FileAccess.open(path, FileAccess.READ)
	if file_access == null:
		printerr("Error opening file: " + path)
		load_button.disabled = false
		return
	var json_obj: JSON = JSON.new()
	var error: Error = json_obj.parse(file_access.get_as_text())
	if error != OK:
		printerr("Error parsing JSON: " + str(error))
		load_button.disabled = false
		return
	var json: Dictionary = json_obj.data
	var serializer: JSONSerializer = JSONSerializer.new()
	serializer.custom_mapping = MAPPING
	var itf: ITF = ITF.new()
	error = serializer.deserialize(json, itf)
	load_button.disabled = false

func load_error(error: Error) -> void:
	printerr("Error loading file: " + str(error))
	load_button.disabled = false
