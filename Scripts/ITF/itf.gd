class_name ITF extends JSONSerializable

var asset: ITFAsset
var scenes: Array[ITFScene] = []
var nodes: Array[ITFNode] = []
var meshes: Array[ITFMesh] = []
var materials: Array[ITFMaterial] = []
var textures: Array[ITFTexture] = []
var images: Array[ITFImage] = []
var samplers: Array[ITFSampler] = []
var buffer_views: Array[ITFBufferView] = []
var buffers: Array[ITFBuffer] = []
var accessors: Array[ITFAccessor] = []
var extensions_used: PackedStringArray = []
var extensions_required: PackedStringArray = []
var extensions: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "asset": ["asset", true, TYPE_DICTIONARY, []],
    "scenes": ["scenes", false, TYPE_ARRAY, []],
    "nodes": ["nodes", false, TYPE_ARRAY, []],
    "meshes": ["meshes", false, TYPE_ARRAY, []],
    "materials": ["materials", false, TYPE_ARRAY, []],
    "textures": ["textures", false, TYPE_ARRAY, []],
    "images": ["images", false, TYPE_ARRAY, []],
    "samplers": ["samplers", false, TYPE_ARRAY, []],
    "bufferViews": ["buffer_views", false, TYPE_ARRAY, []],
    "buffers": ["buffers", false, TYPE_ARRAY, []],
    "accessors": ["accessors", false, TYPE_ARRAY, []],
    "extensionsUsed": ["extensions_used", false, TYPE_ARRAY, []],
    "extensionsRequired": ["extensions_required", false, TYPE_ARRAY, []],
    "extensions": ["extensions", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES
