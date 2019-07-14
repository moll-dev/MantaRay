
struct Ray
    origin::Vec3
    direction::Vec3
    Ray(origin, direction) = new(origin, normalize(direction))
end


# Constructeurs très spéciaux

""" Point projection 
    p(t) = A + t*B
"""
function project(r::Ray, t::Real)
    return r.origin + t * r.direction
end