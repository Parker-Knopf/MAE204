function x = bound(x, l, u)
% Function: Bound value based on given bounds [l, u]
%
% Inputs:
% - x: (float) value to bound
% - l: (float) lowwer bound
% - u: (float) upper bound
%
% Outputs:
% - x: (float) Bounded value

    if (x < l)
        x = l;
    elseif (x > u)
        x = u;
    end
end