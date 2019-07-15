mutable struct HitRecord
    t::Real
    point::Vec3
    normal::Vec3
    hit::Bool
end

function HitRecord()
    return HitRecord(0.0, Vec3(0.0), Vec3(0.0), false)
end