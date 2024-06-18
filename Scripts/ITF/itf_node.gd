class_name ITFNode extends Resource

@export var camera: int
@export var children: PackedInt32Array
@export var skin: int
@export var matrix: PackedFloat32Array = [1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1]
@export var mesh: int
@export var rotation: PackedFloat32Array = [0,0,0,1]
@export var scale: PackedFloat32Array = [1,1,1]
@export var translation: PackedFloat32Array = [0,0,0]
@export var weights: PackedFloat32Array
@export var name: String
@export var extensions: Dictionary
@export var extras: Dictionary
