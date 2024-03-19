function x = floorVal(x, max)
% Function: Bound all values contained in x
%
% Inputs:
% - x: (list[float]) Values to be bounded
% - max: (float) Value to bound by
%
% Outputs:
% - x: (list[float]) Bounded list of Values

    n = length(x);
    for i = 1:n
        if x(i) > max
            x(i) = max;
        elseif x(i) < -max
                x(i) = -max;
        end
    end
end