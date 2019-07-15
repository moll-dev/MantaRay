
struct Ray
    origin::Vec3
    direction::Vec3
    Ray(origin, direction) = new(origin, normalize(direction))
end

function Ray()
    return Ray(Vec3(0.0), Vec3(0.0, 0.0, -1.0))
end

# Constructeurs très spéciaux

""" Point projection 
    p(t) = A + t*B
"""
function project(r::Ray, t::Real)
    return r.origin + t * r.direction
end