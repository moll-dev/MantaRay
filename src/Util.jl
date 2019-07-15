using Distributions

""" Linear Interpolation between two Vec3 """
function lerp(a::Vec3, b::Vec3, t::Real)
    return ((1 - t) * a) + (t * b)
end


""" function to pick random point on unit sphere """
function random_unit_sphere_point()
    # Create a Gaussian Distribution (a.k.a Normal) with μ=0.0, σ=1.0
    # Pick 3 values, X, Y, Z
    # Normalize resulant vector
    return normalize(Vec3(rand(Normal(), 3)))
end

