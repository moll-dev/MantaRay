using Fire
using Images
using FileIO
using Colors
using Printf
using MantaRay


function color(r::Ray, hitlist::HitList)
    rec = collide(hitlist, r, 0.001, floatmax(Float64))
    if rec.hit
        return 0.5 * Vec3(rec.normal .+ 1)
    else
        unit =  normalize(r.direction)
        t = 0.5 * (unit.y + 1.0)
        return (1.0 - t) * Vec3(1.0) + t * Vec3(0.5, 0.7, 1.0)
    end
end

"Make a scene"
@main function make_not_blank(filename::AbstractString)
    nx = 200
    ny = 100
    ns = 5

    # Take into account the aspect ratio here
    llc = Vec3(-2.0, -1.0, -1.0)
    width = Vec3(4.0, 0.0, 0.0)
    height = Vec3(0.0, 2.0, 0.0)
    origin = Vec3(0.0)


    world = HitList()
    addCollider(world, SphereCollider(Vec3(0.0, 0.0, -2.0), 1.2))
    addCollider(world, SphereCollider(Vec3(0.0, -100.5, -2.0), 100))


    camera = Camera()

    img = zeros(RGB{Float32}, ny, nx)
    for j in 1:ny
        for i in 1:nx
            col = Vec3(0.0)
            for s in 1:ns
                u = (i + rand(Float64)) / nx
                v = (j + rand(Float64)) / ny
                r = get_ray(camera, u, v)
                col = col + color(r,world)
            end

            # u = (i + rand(Float64)) / nx
            # v = (j + rand(Float64)) / ny
            # r = get_ray(camera, u, v)
            col = col / ns

            img[ny - j + 1, i] = RGB(col...)
        end 
    end


    return img
    # write(stdout, filename)
    # save("data/" * filename, img)
end