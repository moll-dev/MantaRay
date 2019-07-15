

mutable struct HitList <: Collider
    colliders::Array{Collider}
end

#  Special constructor
function HitList()
    return HitList(Array{Collider, 1}())
end

function addCollider(hl::HitList, c::Collider)
    push!(hl.colliders, c)
end


function collide(hl::HitList, r::Ray, t_min::Real, t_max::Real)
    rec = HitRecord()
    closest_so_far = t_max
    for collider in hl.colliders
        temp_rec = collide(collider, r, t_min, closest_so_far)
        if temp_rec.hit
            closest_so_far = rec.t
            rec = temp_rec
        end
    end
    return rec
end