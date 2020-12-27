inverse(origSide::HorizonSide) = HorizonSide(mod(Int(origSide) + 2, 4))
function moveSide(r, side)
    x = 0
    while isborder(r, side) == false
        move!(r, side)
        putmarker!(r)
        x += 1
    end

    while x > 0
        move!(r, inverse(side))
        x -= 1
    end
end

function main1!(r::Robot)
    moveSide(r, Nord)
    moveSide(r, Sud)
    moveSide(r, Ost)
    moveSide(r, West)
    putmarker!(r)
end
