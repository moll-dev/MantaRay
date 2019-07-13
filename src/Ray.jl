

struct Ray
    origin::Vec3
    direction::Vec3
end


""" Point projection 
    p(t) = A + t*B
"""
function project(r::Ray, t::Integer)
    return r.origin + t * r.direction
end