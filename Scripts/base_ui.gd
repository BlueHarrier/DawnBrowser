class_name BaseUI extends Control

var path_bar: TextEdit
var load_button: Button
var uri: String

func _ready() -> void:
	path_bar = $Panel/Elements/TextEdit
	load_button = $Panel/Elements/Button

	load_button.pressed.connect(on_load_button_pressed)

func on_load_button_pressed() -> void:
	uri = path_bar.text
	if uri == "":
		return
	load_button.disabled = true
	var file: AsyncFile = AsyncFile.from_protocol(uri)
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
	file_access.close()
	DirAccess.remove_absolute(path)
	if error != OK:
		printerr("Error parsing JSON: " + str(error))
		load_button.disabled = false
		return
	var json: Dictionary = json_obj.data
	var serializer: JSONSerializer = JSONSerializer.new()
	serializer.custom_mapping = MAPPING
	var itf: ITF = ITF.new()
	error = serializer.deserialize(json, itf)
	if error != OK:
		printerr("Error deserializing glTF: " + str(error))
	load_button.disabled = false
	print("Loaded glTF: " + uri)

func load_error(error: Error) -> void:
	printerr("Error loading file: " + str(error))
	load_button.disabled = false
