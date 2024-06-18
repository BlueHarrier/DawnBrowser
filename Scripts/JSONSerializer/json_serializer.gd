class_name JSONSerializer extends RefCounted

## All possible types of arrays for fast checking
const ARRAY_TYPES: PackedInt32Array = [
	TYPE_ARRAY,
	TYPE_PACKED_BYTE_ARRAY,
	TYPE_PACKED_INT32_ARRAY,
	TYPE_PACKED_INT64_ARRAY,
	TYPE_PACKED_FLOAT32_ARRAY,
	TYPE_PACKED_FLOAT64_ARRAY,
	TYPE_PACKED_STRING_ARRAY,
	TYPE_PACKED_VECTOR2_ARRAY,
	TYPE_PACKED_VECTOR3_ARRAY,
	TYPE_PACKED_COLOR_ARRAY,
]

## `camelCase` naming convention
const NAME_CAMEL_CASE: NameMapping = NameMapping.CAMEL_CASE

## `PascalCase` naming convention
const NAME_PASCAL_CASE: NameMapping = NameMapping.PASCAL_CASE

## `snake_case` naming convention
const NAME_SNAKE_CASE: NameMapping = NameMapping.SNAKE_CASE

## `SCREAMING_SNAKE_CASE` naming convention
const NAME_SCREAMING_SNAKE_CASE: NameMapping = NameMapping.SCREAMING_SNAKE_CASE

## Default Godot name mapping convention
var godot_naming: NameMapping = NAME_SNAKE_CASE

## Default Json name mapping convention
var json_naming: NameMapping = NAME_CAMEL_CASE

## Custom name mapping for specific classes
## This ditionary expects a class name as a key, and another Dictionary as a value, which
## contains the custom names for each property, being the key the Json name and the value the Godot name.
var custom_mapping: Dictionary = {}

## Custom validation for specific classes
## This dictionary contains the name of each class, which requires a custom validation Callable.
## The Callable must return a boolean value, which will be used to validate the deserialized object, and will receive the object as a parameter.
var validation: Dictionary = {}

## Custom packers for specific classes
## This dictionary expects a class name as a key, and a Callable as a value, which will be used to pack the object into a Variant.
## The Callable must return an Error, and will receive the object and an empty dictionary to fill as paremeters.
var class_packers: Dictionary = {}

## Custom unpackers for specific classes
## This dictionary expects a class name as a key, and a Callable as a value, which will be used to unpack the object from a Variant.
## The Callable must return an Error, and will receive the object and the dictionary as paremeters.
var class_unpackers: Dictionary = {}

## Custom packers for specific properties
## This dictionary expects a class name as a key, and another Dictionary as a value, which contains a Callable for properties that may require 
## special packing for serialization.
## The Callable must return an Error, and will receive the object and the dictionary as paremeters.
var property_packers: Dictionary = {}

## Custom unpackers for specific properties
## This dictionary expects a class name as a key, and another Dictionary as a value, which contains a Callable for properties that may require
## special unpacking during deserialization.
## The Callable must return an Error, and will receive the object and the value as paremeters.
var property_unpackers: Dictionary = {}

## Ignored properties for specific classes
## This dictionary expects a class name as a key, and an Array of property names as a value, which will be ignored during serialization
## and deserialization.
var ignored_properties: Dictionary = {}

## Naming conventions for property remap
enum NameMapping {
	## `camelCase` naming convention
	CAMEL_CASE,
	## `PascalCase` naming convention
	PASCAL_CASE,
	## `snake_case` naming convention
	SNAKE_CASE,
	## `SCREAMING_SNAKE_CASE` naming convention
	SCREAMING_SNAKE_CASE,
}

var _script_cache: Dictionary = {}

# TODO: Serialization function
## Serializes an Object into a JSON dictionary.
## The expected Object must be able to use exported variables.
func serialize(obj: Object, json: Dictionary) -> Error:
	return OK

## Deserializes a JSON dictionary into an Object.
## The expected Object must be able to use exported variables, and expects the dictionary to be of the correct format.
## The function will return an error if the JSON dictionary doesn't map the class, or if there was any errors with class instantiation.
## It will also verify any instance of the classes specified for verification.
func deserialize(json: Dictionary, obj: Object) -> Error:
	var mapping: Dictionary = {}
	var obj_class: String = __find_object_class(obj)
	if class_unpackers.has(obj_class):
		return class_unpackers[obj_class].call(obj)
	var properties: Dictionary = __get_object_valid_properties(obj, obj_class)
	if custom_mapping.has(obj_class):
		mapping = custom_mapping[obj_class]
	var unpackers: Dictionary = {}
	if property_unpackers.has(obj_class):
		unpackers = property_unpackers[obj_class]
	for raw_key: Variant in json.keys():
		var key: String = ""
		if mapping.has(raw_key):
			key = mapping[raw_key]
		else:
			key = __naming_to_godot(raw_key)
		if !properties.has(key):
			return ERR_INVALID_DATA
		if unpackers.has(key):
			var error: Error = unpackers[key].call(obj, json[raw_key])
			if error != OK:
				return error
			continue
		var property: Dictionary = properties[key]
		var type: int = property["type"]
		var value: Variant = json[raw_key]
		if __translate_type(type) != typeof(value):
			return ERR_INVALID_DATA
		if type == TYPE_OBJECT:
			var instance_class: String = property["class_name"]
			var instance: Object = __instantiate_class(instance_class)
			if !instance:
				return ERR_FILE_NOT_FOUND
			var error: Error = deserialize(value, instance)
			if error != OK:
				return error
			obj.set(key, instance)
		elif type in ARRAY_TYPES:
			var array: Array = value as Array
			var error: Error = deserialize_array(array, obj.get(key))
			if error != OK:
				return error
		else:
			obj.set(key, value)
	if validation.has(obj_class):
		var validate: Callable = validation[obj_class]
		if !validate.call(obj):
			return ERR_INVALID_DATA
	return OK

## Deserializes an array of Variants into an array of desired characteristics, when possible.
## The function will return an error if the array is not of the desired type, or if there was any errors with class instantiation.
func deserialize_array(in_array: Array, out_array: Array) -> Error:
	var type: int = out_array.get_typed_builtin()
	if type == TYPE_NIL:
		out_array.assign(in_array)
	else:
		if !__verify_typed_array(in_array, type):
			return ERR_INVALID_PARAMETER
		out_array.resize(in_array.size())
		if type == TYPE_OBJECT:
			var array_class: String = out_array.get_typed_class_name()
			var array_script: Script = out_array.get_typed_script()
			for i in in_array.size():
				var obj: Object = ClassDB.instantiate(array_class)
				if !obj:
					return ERR_FILE_NOT_FOUND
				if array_script:
					obj.set_script(array_script)
				var error: Error = deserialize(in_array[i], obj)
				if error != OK:
					return error
				out_array[i] = obj
		else:
			for i in in_array.size():
				out_array[i] = in_array[i]
	return OK

func __translate_type(type: int) -> int:
	if type == TYPE_OBJECT:
		return TYPE_DICTIONARY
	elif type == TYPE_INT:
		return TYPE_FLOAT
	elif type in ARRAY_TYPES:
		return TYPE_ARRAY
	return type

func __verify_typed_array(array: Array, type: int) -> bool:
	type = __translate_type(type)
	for element: Variant in array:
		if typeof(element) != type:
			return false
	return true

func __get_object_valid_properties(obj: Object, obj_class: String) -> Dictionary:
	var properties: Dictionary = {}
	var property_list: Array = obj.get_property_list()
	var ignore: Array = []
	if ignored_properties.has(obj_class):
		ignore = ignored_properties[obj_class]
	for property: Dictionary in property_list:
		var property_name: String = property["name"]
		if ignore.has(property_name):
			continue
		var usage: int = property["usage"]
		if usage & PROPERTY_USAGE_STORAGE:
			properties[property_name] = property
	return properties

func __instantiate_class(base_class: String) -> Object:
	if ClassDB.class_exists(base_class):
		return ClassDB.instantiate(base_class)
	else:
		return __instantiate_script_class(base_class)

func __instantiate_script_class(base_class: String) -> Object:
	var script: GDScript
	if _script_cache.has(base_class):
		script = _script_cache[base_class]
	else:
		script = __find_class_script(base_class)
		if !script or !script.can_instantiate():
			return null
		_script_cache[base_class] = script
	var instance: Object = ClassDB.instantiate(script.get_instance_base_type())
	instance.set_script(script)
	return instance

func __find_class_script(base_class: String) -> Script:
	var global_classes: Array[Dictionary] = ProjectSettings.get_global_class_list()
	for global_class: Dictionary in global_classes:
		if global_class["class"] == base_class:
			var path: String = global_class["path"]
			return load(path)
	return null

func __find_script_class(script: Script) -> String:
	var global_classes: Array[Dictionary] = ProjectSettings.get_global_class_list()
	for global_class: Dictionary in global_classes:
		if global_class["path"] == script.resource_path:
			return global_class["class"]
	return ""

func __find_object_class(obj: Object) -> String:
	var script: Script = obj.get_script()
	if script:
		var base_class: String = __find_script_class(script)
		if base_class == "":
			return obj.get_class()
		return base_class
	return obj.get_class()

func __naming_to_godot(name: String) -> String:
	return __map_name(name, godot_naming)

func __naming_to_json(name: String) -> String:
	return __map_name(name, json_naming)

func __map_name(name: String, mapping: NameMapping) -> String:
	match mapping:
		NAME_CAMEL_CASE:
			return name.to_camel_case()
		NAME_PASCAL_CASE:
			return name.to_pascal_case()
		NAME_SNAKE_CASE:
			return name.to_snake_case()
		NAME_SCREAMING_SNAKE_CASE:
			return name.to_snake_case().to_upper()
	return name