module MantaRay

export 
    # Vec3 Struct
    Vec3,
    len,
    dot,
    cross,
    normalize,

    # Ray Struct
    Ray,
    project,

    # Util
    Util,
    lerp


include("Vec3.jl") 
include("Ray.jl")
include("Util.jl")

end # module
