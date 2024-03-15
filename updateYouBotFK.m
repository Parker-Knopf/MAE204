function T_se = updateYouBotFK(theta0)
    youBotConfigs

    phi = theta0(1);
    x = theta0(2);
    y = theta0(3);

    T_e0 = FKinBody(M, B, theta0(4:8));

    T_sb = [cos(phi) -sin(phi) 0 x;
            sin(phi) cos(phi) 0 y;
            0 0 1 r;
            0 0 0 1];

    T_bs = inv(T_sb);

%     T_se = T_e0 * inv(T_b0) * T_bs; 
    T_se = T_e0 * T_bs \ T_b0;
end