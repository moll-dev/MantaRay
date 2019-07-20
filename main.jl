using Fire
using Images
using FileIO
using Colors
using Printf
using MantaRay


function color(r::Ray, world::HitList, depth::Int64)
    rec = collide(world, r, 0.001, floatmax(Float64))
    if rec.hit
        scattered = Ray(r.origin, -r.direction)
        attenuation = Vec3()

        scatter_hit, attenuation, scattered = scatter(rec.material, r, rec, attenuation, scattered)
        # if typeof(rec.material) == MetalicMaterial
        #    print("Hit metal!")
        #    print(rec.normal)
        #    print(" ")
        #    print(attenuation)
        #    println()
        if scatter_hit && depth < 10
            return attenuation * color(scattered, world, depth + 1)
        else
            return Vec3(0.0, 0.0, 0.0)
        end
    else
        unit =  normalize(r.direction)
        t = 0.5 * (unit.y + 1.0)
        return (1.0 - t) * Vec3(1.0) + t * Vec3(0.5, 0.7, 1.0)
    end
end


function build_world()
    world = HitList()
    addCollider(world, SphereCollider(
        Vec3(0.0, 0.0, -1.0), 
        0.5, 
        LambertianMaterial(
            Vec3(0.8, 0.3, 0.4)
        )
    ))

    
    addCollider(world, SphereCollider(
        Vec3(-1.0, 0.0, -1.0),
        0.5,
        DielectricMaterial(1.5)
    ))

    addCollider(world, SphereCollider(
        Vec3(-1.0, 0.0, -1.0),
        -0.45,
        DielectricMaterial(1.5)
    ))


    addCollider(world, SphereCollider(
        Vec3(1.0, 0.0, -1.0),
        0.5,
        MetalicMaterial(
            Vec3(0.8, 0.6, 0.2),
            0.8
        )
    ))


    # "Floor"
    addCollider(world, SphereCollider(Vec3(0.0, -100.5, -2.0), 100, LambertianMaterial(Vec3(0.2, 0.8, 0.2))))
    return world
end

"Make a scene"
@main function make_diffuse(width, height, samples)
    nx = width
    ny = height
    ns = samples

    # Take into account the aspect ratio here
    llc = Vec3(-2.0, -1.0, -1.0)
    width = Vec3(4.0, 0.0, 0.0)
    height = Vec3(0.0, 2.0, 0.0)
    origin = Vec3(0.0)


    world = build_world()

    camera = Camera(Vec3(-2, 1, 1), Vec3(0, 0, -1), Vec3(0, 1, 0), 30.0, nx / ny)

    img = zeros(RGB{Float32}, ny, nx)
    for j in 1:ny
        for i in 1:nx
            col = Vec3(0.0)
            for s in 1:ns
                u = (i + rand(Float64)) / nx
                v = (j + rand(Float64)) / ny
                r = get_ray(camera, u, v)
                col = col + color(r,world, 0)
            end

            col = col / ns

            # Gamma correct
            col = Vec3(sqrt(col.x), sqrt(col.y), sqrt(col.z))
            img[ny - j + 1, i] = RGB(col...)
        end 
    end


    return img
    # write(stdout, filename)
    #save("data/" * filename, img)
end