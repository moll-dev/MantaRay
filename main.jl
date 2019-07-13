using Fire
using Images
using FileIO
using Colors
using Printf

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