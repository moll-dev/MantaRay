module MantaRay

export 
    # Vec3 Struct
    Vec3,
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

    # HitRecord
    HitRecord,

    # Collider
    Collider,
    SphereCollider,
    collide,

    # HitList
    HitList,
    addCollider


include("Vec3.jl") 
include("Ray.jl")
include("Camera.jl")
include("Util.jl")
include("HitRecord.jl")
include("Collider.jl")
include("HitList.jl")


end # module
