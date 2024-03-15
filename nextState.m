function x1 = nextState(x0, xDot, dt, xMax)
%     xDot = floorVal(xDot, xMax);

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
    q = odometry(u);

    % Chassis 
    for i = 1:3
        x1(i) = x0(i) + q(i);
    end
end