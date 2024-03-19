function q_k1 = odometry(u, phi0)
% Function: Calculate change in wheel angle given wheel velocities
%
% Inputs:
% - u: (list[float]) Wheel Velocities
% - phi0: (float) Current chassis heading
%
% Outputs:
% - q_k1: (list[float]) Change in Wheel Angle

    load("youBotConfigs.mat", 'r', 'F')

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
           0 cos(phi0) -sin(phi0);
           0 sin(phi0) cos(phi0)]; % Need to update w current phi
    q_k1 = rot * q_b;
end