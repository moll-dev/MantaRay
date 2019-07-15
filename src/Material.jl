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
    fuzz::Float64
end

function scatter(mat::MetalicMaterial, r::Ray, rec::HitRecord, attenuation::Vec3, scattered::Ray)
    reflected = reflect_vector(r.direction, rec.normal)
    scattered = Ray(rec.point, reflected + (mat.fuzz * random_unit_sphere_point()))
    return dot(scattered.direction, rec.normal) > 0, mat.albedo, scattered
end


mutable struct DielectricMaterial <: Material
    idx::Float64
end

function scatter(mat::DielectricMaterial, r::Ray, rec::HitRecord, attenuation::Vec3, scattered::Ray)
    outer_normal = Vec3()
    reflected = reflect_vector(r.direction, rec.normal)

    if dot(r.direction, rec.normal) > 0
        outer_normal = -rec.normal
        boundary_radio = mat.idx
        cosine = dot(r.direction, rec.normal) / len(r.direction)
        cosine = sqrt(1 - clamp(mat.idx * mat.idx * (1 - cosine ^ 2), 0, 1))
    else
        outer_normal = rec.normal
        boundary_radio = 1.0 / mat.idx
        cosine = -dot(r.direction, rec.normal) / len(r.direction)
    end

    is_refracted, refracted = refract_vector(r.direction, outer_normal, boundary_radio)
    if is_refracted
        reflect_prob = schlick(cosine, mat.idx)
    else
        reflect_prob = 1.0
    end

    if rand(Float64) < reflect_prob
        scattered = Ray(rec.point, reflected)
    else
        scattered = Ray(rec.point, refracted)
    end


    if refracted == nothing
        refracted = Vec3()
    end
    return is_refracted, Vec3(1.0, 1.0, 1.0), scattered
end


# Helper Functions
#
#
#
function reflect_vector(v::Vec3, n::Vec3)
    return v - 2 * dot(v, n) * n
end

# TODO Prettify this later
function refract_vector(v::Vec3, n::Vec3, boundary_radio::Float64)
    uv = normalize(v)
    dt = dot(uv, n)
    discriminant = 1.0 - boundary_radio * boundary_radio * (1 - dt ^ 2)
    if discriminant > 0
        return true, boundary_radio * (uv - n * dt) - n * sqrt(discriminant)
    else
        return false, nothing
    end
end

function schlick(cosine::Float64, idx::Float64)
    r0 = (1 - idx) / (1 + idx)
    r0 = r0 ^ 2
    return r0 + (1 - r0) * (1 - cosine) ^ 5
end