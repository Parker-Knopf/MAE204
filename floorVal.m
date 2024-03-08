function x = floorVal(x, max)

    n = length(x);
    for i = 1:n
        if x(i) > max
            x(i) = max;
        elseif x(i) < -max
                x(i) = -max;
        end
    end
end