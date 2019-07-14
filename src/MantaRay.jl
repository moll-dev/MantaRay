module MantaRay



export 
    # Vec3 Struct
    Vec3,
    len,
    dot,
    ⋅,
    cross,
    normalize,

    # Ray Struct
    Ray,
    project,

    # Util
    lerp,

    # Collider
    Collider,
    SphereCollider,
    collide

include("Vec3.jl") 
include("Ray.jl")
include("Util.jl")
include("Collider.jl")


end # module
