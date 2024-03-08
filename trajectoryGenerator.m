function configs = trajectoryGenerator(T_se_i, T_sc_i, T_sc_f, T_ce_g, T_ce_s, k)

    T_se_ci_s  = T_sc_i * T_ce_s; % Standoff cube initial
    T_se_cf_s  = T_sc_f * T_ce_s; % Standoff cube final

    T_se_ci_g = T_sc_i * T_ce_g; % Grasp cube initial

    T0 = [T_se_i, T_se_ci_s, T_se_ci_g, T_se_ci_g, T_se_ci_s, T_se_cf_s, T_sc_f, T_sc_f]; % Inital Configs for every trajectory
    T1 = [T0(2:end), T_se_i]; % Final Configs for every trajectory

    grip = [0 0 1 1 1 1 0 0]; % Final Gripper State at every trajectory
    t = [1 1 1 1 1 1 1 1]; % Time for each trajectory

    n = 0; % Precontruct Configs Length
    for i = 1:length(t)
        n = n + t(i)*k/0.01;
    end

    configs = zeros(n, 13);
    index = 1;
    for i = 1:length(T0)
        N = t(i)*k/0.01;
        configs(index:index+N, :) = CellTtoConfig(ScrewTrajectory(T0(i), T1(i), t(i), N, 3), grip(i));
        index = index+N;
    end
end