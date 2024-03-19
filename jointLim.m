function [x1, sb] = jointLim(x0)
% Function: Limit joint angles based on youBot
%
% Inputs:
% - x0: (list[float]) Joint angles
%
% Outputs:
% - x1: (list[float]) Joint angles limited to respective bounds
% - sb: (list[logical]) Logical array of arm joints hitting limits or not

    q = x0(4:8); % Arm joint angles
    
    qLim1 = [-inf, -3*pi/4, -5*pi/6, -5*pi/6, -inf]; % Lower Limits for arm joint angles
    qLim2 = [inf, pi/2, 5*pi/6, 5*pi/6, inf]; % Upper Limits for arm joint angles
    
    sb = false(1, length(q));
    for i = 1:length(q)
        [q(i), sb(i)] = bound(q(i), qLim1(i), qLim2(i));
    end
    
    x1 = [x0(1:3), q, x0(9:12)];

end