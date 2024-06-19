# DawnBrowser

Testing browser for the [Isle Ecosystem project](https://github.com/BlueHarrier/IsleEcosystem).

## Dependencies

This project uses Godot Rust to work, don't forget to install all [Rust development tools](https://godot-rust.github.io/book/intro/index.html).

Rust files can be found in `Extensions/libdawn`.

## Current status

- Godot's internal glTF module is optimized for its own workflow, which doesn't match glTF design philosophy. A new glTF extension is being made.
- Implementing the following ISLE extensions:
    - [ ] ISLE_canvas
    - [ ] ISLE_light_shadows
    - [ ] ISLE_mirror
- Implementing the following third-party extensions:
    - [ ] KHR_animation_pointer
    - [ ] KHR_audio_emitter
    - [ ] KHR_draco_mesh_compression
    - [ ] KHR_lights_punctual
    - [ ] KHR_materials_anisotropy
    - [ ] KHR_materials_clearcoat
    - [ ] KHR_materials_dispersion
    - [ ] KHR_materials_emissive_strength
    - [ ] KHR_materials_ior
    - [ ] KHR_materials_iridescence
    - [ ] KHR_materials_sheen
    - [ ] KHR_materials_specular
    - [ ] KHR_materials_transmission
    - [ ] KHR_materials_unlit
    - [ ] KHR_materials_variants
    - [ ] KHR_materials_volume
    - [ ] KHR_mesh_quantization
    - [ ] KHR_texture_basisu
    - [ ] KHR_texture_transform
    - [ ] KHR_xmp_json_ld
    - [ ] OMI_link
    - [ ] OMI_physics_body
    - [ ] OMI_physics_joint
    - [ ] OMI_physics_shape
    - [ ] OMI_seat
    - [ ] OMI_spawn_point
    - [ ] VRMC_materials_hdr_emissiveMultiplier
    - [ ] VRMC_materials_mtoon
- Async file load ready for local files and HTTP files.