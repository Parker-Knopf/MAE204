function x1 = jointLim(x0)
% Function: Limit joint angles based on youBot
%
% Inputs:
% - x0: (list[float]) Joint angles
%
% Outputs:
% - x1: Joint angles limited to respective bounds

q = x0(4:8); % Arm joint angles

qLim1 = [-inf, -3*pi/4, -5*pi/6, -5*pi/6, -inf]; % Lower Limits for arm joint angles
qLim2 = [inf, pi/2, 5*pi/6, 5*pi/6, inf]; % Upper Limits for arm joint angles

q(1) = bound(q(1), qLim1(1), qLim2(1));
q(2) = bound(q(2), qLim1(2), qLim2(2));
q(3) = bound(q(3), qLim1(3), qLim2(3));
q(4) = bound(q(4), qLim1(4), qLim2(4));
q(5) = bound(q(5), qLim1(5), qLim2(5));

x1 = [x0(1:3), q, x0(9:12)];

end