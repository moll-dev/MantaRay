using Fire


"Run and paint a picture"
@main function repeat_string(message::AbstractString, times::Integer=3; color::Symbol=:normal)
    for i in 1:times
        print_with_color(color, message)
    end
end