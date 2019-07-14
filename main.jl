using Fire
using Images
using FileIO
using Colors
using Printf
using MantaRay

"Run and paint a picture"
@main function repeat_string(message::AbstractString, times::Integer=3; color::Symbol=:normal)
    for i in 1:times
        print_with_color(color, message)
    end
end


""" 
Convert Colors.jl RGB to tuple of ints
"""
function RGB_to_int(color::RGB, scalar::Integer=255)
    r = floor(Int, scalar * color.r)
    g = floor(Int, scalar * color.g)
    b = floor(Int, scalar * color.b)

    return (r, g, b)
end


"Make Example PPM"
@main function make_ppm(filename::AbstractString)
    x = 200
    y = 100

    fs = open(filename, "w")
    header = @sprintf("P3 \n%d %d \n255\n", x, y)
    write(fs, header)
 
    img = zeros(RGB{Float32}, x, y)
    for j in 1:y
        for i in 1:x
            color = RGB(i / x, j / y, 0.2)
            write(fs, join(RGB_to_int(color), " ") * "\n")
        end
    end
    close(fs)   

end

"Make a png"
@main function make_png(filename::AbstractString)
    nx = 100
    ny = 200

    # Create 2d array of RGB values in memory
    img = zeros(RGB{Float32}, nx, ny)
    for j in 1:ny
        for i in 1:nx
            color = RGB(i / nx, j / ny, 0.2)
            img[i,j] = color
        end
    end
    
    # Save back to disk.
    write(stdout, filename)
    save("data/" * filename, img)
end


"Color lerp"
function color_lerp(r::Ray)

    # Render sphere
    t = hit_sphere(Vec3(-0.5, 0.0, -10.0), 5, r)
    if t > 0.0
        normal = normalize(project(r, t) - Vec3(0,0,-1))
        col = 0.5 * Vec3(normal .+ 1)
        return RGB{Float64}(col...)
    end

    # Render background
    normal = r.direction
    t = 0.5 * (normal.y + 1.0)
    col = lerp(Vec3(1.0, 1.0, 1.0), Vec3(0.5, 0.7, 1.0), t)
    return RGB(col...) 
end

function hit_sphere(center::Vec3, radius::Real, ray::Ray)
    oc = ray.origin - center
    a = dot(ray.direction, ray.direction)
    b = 2.0 * dot(oc, ray.direction)
    c = dot(oc, oc) - radius ^ 2
    discriminant = b^2 - 4*a*c
    if discriminant < 0 
        return -1.0
    else
        return (-b - sqrt(discriminant) ) / (2.0 * a)
    end
end

"Make a scene"
@main function make_blank(filename::AbstractString)
    nx = 200
    ny = 100

    # Take into account the aspect ratio here
    llc = Vec3(-2.0, -1.0, -1.0)
    width = Vec3(4.0, 0.0, 0.0)
    height = Vec3(0.0, 2.0, 0.0)
    origin = Vec3(0.0)


    img = zeros(RGB{Float32}, ny, nx)
    for j in 1:ny
        for i in 1:nx
            u, v  = i / nx, j / ny
            r = Ray(origin, llc + u * width + v * height)
            col = color_lerp(r)
            img[j, i] = col
        end 
    end

    return img
    # write(stdout, filename)
    # save("data/" * filename, img)
end
