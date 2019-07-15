abstract type Material end

struct HitRecord
    t::Real
    point::Vec3
    normal::Vec3
    hit::Bool
    material::Union{Material, Nothing}
end

function HitRecord()
    return HitRecord(0.0, Vec3(0.0), Vec3(0.0), false, nothing)
end

function HitRecord(t::Real, point::Vec3, normal::Vec3, hit::Bool)
    return HitRecord(
        t, 
        point, 
        normal,
        hit,
        nothing
    )
end


# Generic Materials


mutable struct LambertianMaterial <: Material
    albedo::Vec3
end

function scatter(mat::LambertianMaterial, r::Ray, rec::HitRecord, attenuation::Vec3, scattered::Ray)
    target = rec.point + rec.normal + random_unit_sphere_point()
    return true, mat.albedo, Ray(rec.point, target - rec.point)
end


mutable struct MetalicMaterial <: Material
    albedo::Vec3
end

function scatter(mat::MetalicMaterial, r::Ray, rec::HitRecord, attenuation::Vec3, scattered::Ray)
    reflected = reflect_vector(r.direction, rec.normal)
    return dot(scattered.direction, rec.normal) > 0, mat.albedo, Ray(rec.point, reflected)
end





