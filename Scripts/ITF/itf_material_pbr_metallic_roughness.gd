class_name ITFMaterialPBRMetallicRoughness extends JSONSerializable

var base_color_factor: PackedFloat32Array = [1, 1, 1, 1]
var base_color_texture: ITFTextureInfo
var metallic_factor: float = 1
var roughness_factor: float = 1
var metallic_roughness_texture: ITFTextureInfo
var extension: Dictionary
var extras: Dictionary

const PROPERTIES: Dictionary = {
    "baseColorFactor": ["base_color_factor", false, TYPE_ARRAY, []],
    "baseColorTexture": ["base_color_texture", false, TYPE_DICTIONARY, []],
    "metallicFactor": ["metallic_factor", false, TYPE_FLOAT, []],
    "roughnessFactor": ["roughness_factor", false, TYPE_FLOAT, []],
    "metallicRoughnessTexture": ["metallic_roughness_texture", false, TYPE_DICTIONARY, []],
    "extensions": ["extension", false, TYPE_DICTIONARY, []],
    "extras": ["extras", false, TYPE_DICTIONARY, []]
}

func _get_property_map() -> Dictionary:
    return PROPERTIES

func _deserialize_object(property: String, json: Dictionary) -> Error:
    match property:
        "baseColorTexture":
            base_color_texture = ITFTextureInfo.new()
            return base_color_texture.deserialize(json)
        "metallicRoughnessTexture":
            metallic_roughness_texture = ITFTextureInfo.new()
            return metallic_roughness_texture.deserialize(json)
    return ERR_INVALID_DATA
