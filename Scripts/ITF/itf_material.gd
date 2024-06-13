class_name ITFMaterial extends JSONSerializable

var pbr_metallic_roughness: ITFMaterialPBRMetallicRoughness
var normal_texture: ITFMaterialNormalTextureInfo
var occlusion_texture: ITFMaterialOcclussionTextureInfo
var emissive_texture: ITFTextureInfo
var emissive_factor: PackedVector3Array
var alpha_mode: String = "OPAQUE"
var alpha_cutoff: float = 0.5
var double_sided: bool = false

const PROPERTIES: Dictionary = {
    "pbrMetallicRoughness": ["pbr_metallic_roughness", true, TYPE_DICTIONARY, []],
    "normalTexture": ["normal_texture", false, TYPE_DICTIONARY, []],
    "occlusionTexture": ["occlusion_texture", false, TYPE_DICTIONARY, []],
    "emissiveTexture": ["emissive_texture", false, TYPE_DICTIONARY, []],
    "emissiveFactor": ["emissive_factor", false, TYPE_ARRAY, []],
    "alphaMode": ["alpha_mode", false, TYPE_STRING, [
        "OPAQUE",
        "MASK",
        "BLEND"
    ]],
    "alphaCutoff": ["alpha_cutoff", false, TYPE_FLOAT, []],
    "doubleSided": ["double_sided", false, TYPE_BOOL, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES

func _deserialize_object(property: String, json: Dictionary) -> Error:
    match property:
        "pbrMetallicRoughness":
            pbr_metallic_roughness = ITFMaterialPBRMetallicRoughness.new()
            return pbr_metallic_roughness.deserialize(json)
        "normalTexture":
            normal_texture = ITFMaterialNormalTextureInfo.new()
            return normal_texture.deserialize(json)
        "occlusionTexture":
            occlusion_texture = ITFMaterialOcclussionTextureInfo.new()
            return occlusion_texture.deserialize(json)
        "emissiveTexture":
            emissive_texture = ITFTextureInfo.new()
            return emissive_texture.deserialize(json)
    return ERR_PARSE_ERROR
