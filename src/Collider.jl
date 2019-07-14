

abstract type Collider end

struct SphereCollider <: Collider
    pos::Vec3
    radius::Real
end

function collide(sc::SphereCollider, r::Ray, t_min::Real, t_max::Real)
    oc = r.origin - sc.pos
    a = dot(r.direction, r.direction)
    b = 2.0 * dot(oc, r.direction)
    c = dot(oc, oc) - sc.radius ^ 2
    discriminant = b^2 - 4*a*c
    if discriminant < 0 
        return -1.0
    else
        return (-b - sqrt(discriminant) ) / (2.0 * a)
    end
end