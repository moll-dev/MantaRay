

abstract type Collider end

mutable struct SphereCollider <: Collider
    point::Vec3
    radius::Real
end

function collide(sc::SphereCollider, r::Ray, t_min::Real, t_max::Real)
    oc = r.origin - sc.point
    a = dot(r.direction)
    b = dot(oc, r.direction)
    c = dot(oc) - sc.radius ^ 2
    discriminant = b^2 - a*c
    if discriminant > 0 

        # If the front side is visible
        t = -b - sqrt(discriminant)  /  a
        if t_min < t < t_max
            point = project(r, t)
            return HitRecord(
                t,
                point,
                (point - sc.point) / sc.radius,
                true
            )
        end

        # Otherwise, we might have hit just the back.
        t = -b + sqrt(discriminant) / a
        if t_min < t < t_max
            point = project(r, t)
            return HitRecord(
                t,
                point,
                (point - sc.point) / sc.radius,
                true
            )
        end

    end
    return HitRecord(0, Vec3(0.0), Vec3(0.0), false)

end