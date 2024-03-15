function Jb = youBotJb(X, theta0)
    youBotConfigs

    eomg = 0.0001;
    ev = 0.0001;
    
    phi = theta0(1);
    x = theta0(2);
    y = theta0(3);

    F6 = [zeros(1,4);
        zeros(1,4);
        F.*(r/4);
        zeros(1,4)];
    
    T_0s = [cos(phi) -sin(phi) 0 x;
            sin(phi) cos(phi) 0 y;
            0 0 1 r;
            0 0 0 1];
     
    T_0e = X \ T_0s;

    Jbase = Adjoint(inv(T_0e)*inv(T_b0))*F6;

    if size(theta0, 2) > 1
        theta0 = theta0';
    end

    B = B(:, 4:8); % NEED TO FIX THIS
    [theta, null] = IKinBody(B, M, X, theta0(4:8), eomg, ev);
    Jb = [Jbase JacobianBody(B, theta)]
end
