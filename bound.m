function [x, state] = bound(x, l, u)
% Function: Bound value based on given bounds [l, u]
%
% Inputs:
% - x: (float) value to bound
% - l: (float) lower bound
% - u: (float) upper bound
%
% Outputs:
% - x: (float) Bounded value
% - state: (logical) False: Limited by bound, True: Within bound

    state = false;
    if (x < l) % compares x value to lower limit, if less redefines x
        x = l;
    elseif (x > u) % compares x value to upper limit, if greater redifines x
        x = u;
    else %if x within limits, returns true
        state = true;
    end
end