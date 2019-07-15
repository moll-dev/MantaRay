module MantaRay

export 
    # Vec3 Struct
    Vec3,
    MutableVec3,
    len,
    dot,
    ⋅,
    cross,
    normalize,

    # Camera 
    Camera,
    get_ray,

    # Ray Struct
    Ray,
    project,

    # Util
    lerp,
    random_unit_sphere_point,
    reflect_vector,

    # Material
    Material,
    LambertianMaterial,
    MetalicMaterial,
    HitRecord,
    addCollider,
    scatter,

    # Collider
    Collider,
    SphereCollider,
    collide,

    # HitList
    HitList


include("Vec3.jl") 
include("Ray.jl")
include("Camera.jl")
include("Util.jl")
include("Material.jl")
include("Collider.jl")
include("HitList.jl")


end # module
