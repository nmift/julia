include("../tutors.jl")

function find_marker(r)
    n = 1
    side = Up
    while ismarker(r)==false
        for _ in 1:2
            find_marker(r, side, n)
            side = right(side)
        end
        n+=1
    end
end

function find_marker(r, side, n)
    for _ in 1:n
        if ismarker(r)
            return nothing
        end
        move!(r,side)
    end
end
