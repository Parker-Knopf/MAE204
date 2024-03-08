function x1 = nextState(x0, xDot, dt, xMax)
    xDot = floorVal(xDot, xMax);

    x1 = x0;
    r = 0.0475;
    l = 0.47 / 2;
    w = 0.3 / 2;
    
    for i = 4:8
        x1(i) = x0(i) + xDot(i)*dt;
    end

    for i = 9:12
        x1(i) = x0(i) + xDot(i-3);
    end

    u = xDot(6:end)';
    q = odometry(u, w, l, r);

    for i = 1:3
        x1(i) = x0(i) + q(i);
    end
end