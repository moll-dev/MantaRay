
""" Linear Interpolation between two Vec3 """
function lerp(a::Vec3, b::Vec3, t::Real)
    return (1 - t) * a + t * b
end
