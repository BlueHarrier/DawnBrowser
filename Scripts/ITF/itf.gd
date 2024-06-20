class_name ITF extends Resource

@export var asset: ITFAsset
@export var scene: int
@export var scenes: Array[ITFScene] = []
@export var nodes: Array[ITFNode] = []
@export var meshes: Array[ITFMesh] = []
@export var materials: Array[ITFMaterial] = []
@export var textures: Array[ITFTexture] = []
@export var images: Array[ITFImage] = []
@export var samplers: Array[ITFSampler] = []
@export var buffer_views: Array[ITFBufferView] = []
@export var buffers: Array[ITFBuffer] = []
@export var accessors: Array[ITFAccessor] = []
@export var animations: Array[ITFAnimation] = []
@export var skins: Array[ITFSkin] = []
@export var cameras: Array[ITFCamera] = []
@export var extensions_used: PackedStringArray = []
@export var extensions_required: PackedStringArray = []
@export var extensions: Dictionary
@export var extras: Dictionary
