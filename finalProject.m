clear all; close all; clc;

%% Parameters
trajectories
youBotConfigs

kp = zeros(6);
ki = zeros(6);

xMax = 1000; % Change this later

%% Trajectories

t = [1 1 1 1 1 1 1 1 1];
k = 3;
dt = k / 0.01;
X = trajectoryGenerator(T_se_i, T_sc_i, T_sc_f, T_ce_g, T_ce_s, k, t);

Xi = T_se_ai;
theta0 = zeros(12, 1); % Update an initial guess here
X_errs = zeros(length(X), 6);
state = zeros(length(X), 13);
for i = 1:(length(X)-1)
    % IDK what X should be
    [V, u, dTheta, X_errs(i, :)] = feedbackControl(Xi, configToX(X(i, :)), configToX(X(i+1, :)), kp, ki, dt, theta0);
    state(i, :) = [nextState(theta0, [dTheta', u'], dt, xMax), X(i, end)];
    theta0 = state(i, 1:12)';
    Xi = updateYouBotFK(theta0);
end

kn = 1;
X_errs = X_errs(1:kn:end, :);
configs = X(1:kn:end, :);

csvwrite("finalProjectStates.csv", state)
csvwrite("finalProjectErrors.csv", X_errs)
csvwrite("finalProjectConfigs.csv", configs)