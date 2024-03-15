function X_0e = SpaceToArmFrame(X_se, theta)
    load("youBotConfigs.mat", 'T_b0', 'z0')

    phi = theta(1);
    x = theta(2);
    y = theta(3);

    T_sb = [cos(phi) -sin(phi) 0 x;
            sin(phi) cos(phi) 0 y;
            0 0 1 z0;
            0 0 0 1];

    X_0e = TransInv(T_b0) * TransInv(T_sb) * X_se
end