function Jb = youBotJb(X, theta0)
    load("youBotConfigs.mat", 'B', 'F', 'r', 'z0', 'T_b0')
    
    phi = theta0(1);
    x = theta0(2);
    y = theta0(3);

    F6 = [zeros(1,4);
        zeros(1,4);
        F.*(r/4);
        zeros(1,4)];
    
    T_sb = [cos(phi) -sin(phi) 0 x;
            sin(phi) cos(phi) 0 y;
            0 0 1 z0;
            0 0 0 1];
     
    T_0e = TransInv(T_b0) * TransInv(T_sb) * X;

    Jbase = Adjoint(TransInv(T_0e)*TransInv(T_b0))*F6;

    if size(theta0, 2) > 1
        theta0 = theta0';
    end

    Jb = [Jbase JacobianBody(B, theta0(4:8))];
end
