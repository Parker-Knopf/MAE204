function x1 = nextState(x0, xDot, dt, xMax)
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

    xDot = floorVal(xDot, xMax);

    x1 = x0';
    
    % Joint Angles
    for i = 4:8
        x1(i) = x0(i) + xDot(i-3)*dt;
    end

    % Wheel Angles
    for i = 9:12
        x1(i) = x0(i) + xDot(i-3)*dt;
    end

    u = xDot(6:end)'*dt;
    phi = x0(1);
    q = odometry(u, phi);

    % Chassis 
    for i = 1:3
        x1(i) = x0(i) + q(i);
    end
end