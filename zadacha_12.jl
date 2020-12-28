include("../tutors.jl")
size = 0
robot_pos = [0, 0]

function mark_chess(r::Robot, n::Int = 0)
    global size
    
    if n != 0
        size = n
    end

    side = Right
    mark_row(r, side)
    while isborder(r, Up) == false
        move_decart!(r, Up)
        side = inverse(side)
        mark_row(r,side)
    end

end
