using Parameters

@with_kw struct Camera
    lower_left_corner = Vec3(-2.0, -1.0, -1.0)
    horizontal = Vec3(4.0, 0.0, 0.0)
    vertical = Vec3(0.0, 2.0, 0.0)
    origin = Vec3(0.0)
end

function Camera(lookfrom::Vec3, lookat::Vec3, up::Vec3, vfov::Float64, aspect::Float64)
    θ = vfov * π / 180
    half_height = tan(θ/2)
    half_width = aspect * half_height
    w = normalize(lookfrom - lookat)
    u = normalize(cross(up, w))
    v = cross(w,u)

    origin = lookfrom
    lower_left_corner = origin - half_width * u - half_height * v - w
    horizontal = 2 * half_width * u
    vertical = 2 * half_height * v
    return Camera(lower_left_corner, horizontal, vertical, origin)
end

function get_ray(c::Camera, u::Real, v::Real)
    x = u * c.horizontal
    y = v * c.vertical - c.origin
    direction = c.lower_left_corner + x + y
    return Ray(c.origin, direction)
end

function random_in_unit_disk()
    θ = rand(Float64)
    return Vec3(cos(θ), sin(θ), 0)
end