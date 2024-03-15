function q_k1 = odometry(u)
    youBotConfigs

    v = (r/4) .* (F * u);
    omg = v(1);
    v_x = v(2);
    v_y = v(3);
    
    if omg == 0
        q_b = [0, v_x, v_y]';
    else
        q_b = [omg, (v_x*sin(omg) + v_y*(cos(omg) - 1))/omg, (v_y*sin(omg) + v_x*(1 - cos(omg)))/omg]';
    end
    rot = [1 0 0;
           0 cos(omg) -sin(omg);
           0 sin(omg) cos(omg)];
    q_k1 = rot * q_b;
end