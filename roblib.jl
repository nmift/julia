Left  = West
Up    = Nord
Right = Ost 
Down  = Sud
inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))
left(side::HorizonSide) =  HorizonSide(mod(Int(side)+1, 4))
right(side::HorizonSide) = HorizonSide(mod(Int(side)-1, 4))
function putmarkers!(r::Robot, side::HorizonSide)
    putmarker!(r)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end
function putmarkers!(r::Robot, side::HorizonSide, count::Int)
    putmarker!(r)
    while count!=0
        move!(r,side)
        putmarker!(r)
        count -= 1
    end
end
move_by_markers(r::Robot, side::HorizonSide) = while ismarker(r)==true move!(r,side) end
movements!(r::Robot, side::HorizonSide) = while isborder(r,side)==false move!(r,side) end 
movements!(r::Robot, side::HorizonSide, num_steps::Int) = for _ in 1:num_steps move!(r,side) end
function get_num_movements!(r::Robot, side::HorizonSide)
    num_steps = 0
    while isborder(r,side)==false 
        move!(r,side) 
        num_steps += 1    
    end
    return num_steps
end
function movements!(r, sides::NTuple{2,HorizonSide}, num_steps::Vector{Any})
    for (i,n) in enumerate(num_steps)
        movements!(r, sides[mod(i-1, length(sides))+1], n)
    end
end
function through_rectangles_into_angle(r,angle::NTuple{2,HorizonSide})
    num_steps = []
    while (isborder(r,angle[1]) == false || isborder(r,angle[2]) == false)
        push!(num_steps, get_num_movements!(r, angle[2]))
        push!(num_steps, get_num_movements!(r, angle[1]))
    end
    return num_steps
end
function move_if_possible!(r::Robot, direct_side::HorizonSide)::Bool
    left_side = right(direct_side)
    right_side = inverse(left_side)
    num_of_steps = 0

    if isborder(r, direct_side) == false
        move!(r, direct_side)
        result = true
    else
        while isborder(r, direct_side) == true
            if isborder(r, left_side) == false
                move!(r, left_side)
                num_of_steps += 1
            else
                break
            end
        end
        if isborder(r, direct_side) == false
            move!(r, direct_side)
            while isborder(r, right_side) == true
                move!(r, direct_side)
            end
            result = true
        else
            result = false
        end
        while num_of_steps > 0
            num_of_steps -= 1
            move!(r, right_side)
        end
    end

    return result
end
movements_if_possible!(r::Robot, side::HorizonSide) = while isborder(r,side)==false move_if_possible!(r,side) end 
movements_if_possible!(r::Robot, side::HorizonSide, num_steps::Int) = for _ in 1:num_steps move_if_possible!(r,side) end
function movements_if_possible!(r, sides::NTuple{2,HorizonSide}, num_steps::Vector{Any})
    for (i,n) in enumerate(num_steps)
        movements_if_possible!(r, sides[mod(i-1, length(sides))+1], n)
    end
end
function putmarkers_if_possible!(r::Robot, side::HorizonSide)
    putmarker!(r)
    while move_if_possible!(r, side) == true
        putmarker!(r)
    end
end
function putmarkers_if_possible!(r::Robot, side::HorizonSide, count::Int)
    putmarker!(r)
    while count!=0
        move_if_possible!(r, side)
        putmarker!(r)
        count -= 1
    end
end
function get_num_movements_if_possible!(r::Robot, side::HorizonSide)
    num_steps = 0 
    while move_if_possible!(r, side) == true
        num_steps += 1
    end 
    return num_steps
end
function mark_and_enumerate_if_possible!(r::Robot, side::HorizonSide)
    num_steps = 0 

    putmarker!(r)
    while move_if_possible!(r, side) == true
        putmarker!(r)
        num_steps += 1
    end 
    return num_steps
end
