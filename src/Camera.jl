using Parameters

@with_kw struct Camera
    lower_left_corner = Vec3(-2.0, -1.0, -1.0)
    horizontal = Vec3(4.0, 0.0, 0.0)
    vertical = Vec3(0.0, 2.0, 0.0)
    origin = Vec3(0.0)
end

function get_ray(c::Camera, u::Real, v::Real)
    x = u * c.horizontal
    y = v * c.vertical - c.origin
    direction = c.lower_left_corner + x + y
    return Ray(c.origin, direction)
end