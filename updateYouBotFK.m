function T_se = updateYouBotFK(theta0)
    youBotConfigs

    phi = theta0(1);
    x = theta0(2);
    y = theta0(3);

    T_e0 = FKinBody(M, B, theta0(4:8));

    T_sb = [cos(phi) -sin(phi) 0 x;
            sin(phi) cos(phi) 0 y;
            0 0 1 z0;
            0 0 0 1];

    T_se = T_sb * T_b0 * TransInv(T_e0);
end