class_name ITFMaterial extends Resource

@export var name: String
@export var pbr_metallic_roughness: ITFMaterialPBRMetallicRoughness
@export var normal_texture: ITFMaterialNormalTextureInfo
@export var occlusion_texture: ITFMaterialOcclussionTextureInfo
@export var emissive_texture: ITFTextureInfo
@export var emissive_factor: PackedVector3Array
@export var alpha_mode: String = "OPAQUE"
@export var alpha_cutoff: float = 0.5
@export var double_sided: bool = false
