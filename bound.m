function [x, state] = bound(x, l, u)
% Function: Bound value based on given bounds [l, u]
%
% Inputs:
% - x: (float) value to bound
% - l: (float) lowwer bound
% - u: (float) upper bound
%
% Outputs:
% - x: (float) Bounded value
% - state: (logical) False: Limited by bound, True: Within bound

    state = false;
    if (x < l)
        x = l;
    elseif (x > u)
        x = u;
    else
        state = true;
    end
end