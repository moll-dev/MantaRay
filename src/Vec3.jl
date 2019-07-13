import Base.+
import Base.-
import Base.*
import Base./
import Base.splat
import Base.getindex
import Base.iterate
import Base.show

using Printf


# Limit the values used in Vec3 to the Reals. (imaginary maybe soon)
struct Vec3{T <: Real}
    x::T
    y::T
    z::T
end

# Constructeurs très spéciaux

""" Naked constructor """
function Vec3()
    return Vec3{Float64}(0)
end

""" One value, non-typed """
function Vec3(value::Real)
    return Vec3(value, value, value)
end

""" One value, typed """
function Vec3{T}(value) where {T <: Real}
    return Vec3(T(value))
end

""" 1d Array """
function Vec3(values::Array{<:Real, 1})
    len = length(values)
    if len > 3 || len < 3
        error(@sprintf("Tried to create a Vec3 from an Array of size: %d ", len))
    end

    # Splat our values into a new vec...
    return Vec3(values...)
end


""" Show """
function display(a::Vec3)
    show(stdout, "text/plain", a)
end


""" Vector iteration """
function iterate(a::Vec3)
    state = 1
    return iterate(a, state)
end

function iterate(a::Vec3, state)
    if state > 3
        return nothing
    end
    return a[state], state + 1
end

function length(a::Vec3)
    return 3
end


""" Vector identity """
function +(a::Vec3)
    return a
end


""" Vector inverse """
function -(a::Vec3)
    return Vec3(-a.x, -a.y, -a.z)
end


""" Vector index """
function getindex(a::Vec3, index::Integer)
    getfield(a, index)
end


""" Vector addition """
function +(a::Vec3, b::Vec3)
    # NB: this is basically just .+ with a cast because we made these types iterable.
    return Vec3(a .+ b)
end


""" Vector subtraction """
function -(a::Vec3, b::Vec3)
    return Vec3(a .- b)
end


""" Vector multiplication """
function *(a::Vec3, x::Real)
    return Vec3(a .* x)
end

function *(a::Vec3, b::Vec3)
    return Vec3(a .* b)
end


""" Vector division """
function /(a::Vec3, x::Real)
    return Vec3(a ./ x)
end 

function /(a::Vec3, b::Vec3)
    return Vec3(a ./ b)
end


""" Vector dot product """
function dot(a::Vec3, b::Vec3)
    # NB: Pairwise multiplication, then sum, technically can use
    return sum(a .* b)
end

# Fancy latex version \cdot
function ⋅(a::Vec3, b::Vec3)
    return dot(a, b)
end


""" Vector cross product """
function cross(a::Vec3, b::Vec3)
    return Vec3(a.y * b.z - a.z * b.y,
                a.z * b.x - a.x * b.z,
                a.x * b.y - a.y * b.x)
end


""" Vector squared length """
function squared_length(a::Vec3)
    return sum(a .* a)
end


""" Vector length """
function len(a::Vec3)
    return sqrt(squared_length(a))
end


""" Unit vector """
function unit(a::Vec3)
    return a / len(a)
end