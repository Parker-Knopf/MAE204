function [x1, sb] = nextState(x0, xDot, dt, xMax)
% Function: Calculates the next state (joint angles) of youBot
%
% Inputs:
% - x0: (list[float]) Current Joint Values
% - xDot: (list[float]) Current Joint Velocities
% - dt: (float) Time Step s
% - xMax: (float) Largest allowed joint velocity
%
% Outputs:
% - x1: (list[float]) Next Step Joint Values given in state protocal
% - sb: (list[logical]) Logical array of arm joints hitting limits or not

    xDot = bound(xDot, -xMax, xMax);

    x1 = x0';
    
    % Joint Angles
    for i = 4:8 %updates joint angles using euler approximation
        x1(i) = x0(i) + xDot(i-3)*dt;
    end

    % Wheel Angles
    for i = 9:12 %updates wheel angles using euler approximation
        x1(i) = x0(i) + xDot(i-3)*dt;
    end

    u = xDot(6:end)'*dt;
    phi = x0(1);
    q = odometry(u, phi);

    % Chassis 
    for i = 1:3 %updates chasis with updated q
        x1(i) = x0(i) + q(i);
    end

    [x1, sb] = jointLim(x1);
end