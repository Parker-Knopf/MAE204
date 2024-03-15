clear all; close all; clc;

%% Parameters
trajectories
load("youBotConfigs.mat")

kp = zeros(6);
ki = zeros(6);

% kp = eye(6);
% ki = eye(6);

xMax = 1000; % Change this later

%% Trajectories

t = [2.5 1 1 1 1 4 1 1 2.5];
k = 10;
dt = 0.01 / k;
X = trajectoryGenerator(T_se_i, T_sc_i, T_sc_f, T_ce_g, T_ce_s, k, t);

Xi = T_se_ai;
[theta, s] = IKinBody(B, M, SpaceToArmFrame(Xi, zeros(1,3)), [0, 1.38, -1, -.4, 0]', 0.00001, 0.00001);
theta0 = [zeros(1,3), theta', zeros(1,4)]'; % Initial Guess
X_errs = zeros(length(X), 6);
state = zeros(length(X), 13);
state(1, 1:12) = theta0';
for i = 1:(length(X)-1)
    [V, u, dTheta, X_errs(i, :)] = feedbackControl(Xi, configToX(X(i, :)), configToX(X(i+1, :)), kp, ki, dt, theta0);
    state(i+1, :) = [nextState(theta0, [dTheta', u'], dt, xMax), X(i, end)];
    theta0 = state(i+1, 1:12)';
    Xi = updateYouBotFK(theta0);
end

X_errs = X_errs(1:k:end, :);
configs = X(1:k:end, :);

csvwrite("finalProjectStates.csv", state)
csvwrite("finalProjectErrors.csv", X_errs)
csvwrite("finalProjectConfigs.csv", configs)