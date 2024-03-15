clear all; close all; clc;

%% Parameters
trajectories
load("youBotConfigs.mat")

kp = zeros(6);
ki = zeros(6);

xMax = 1000; % Change this later

%% Trajectories

t = [10 1 1 1 1 1 1 1 1];
k = 1;
dt = 0.01 / k;
X = trajectoryGenerator(T_se_i, T_sc_i, T_sc_f, T_ce_g, T_ce_s, k, t);

Xi = T_se_ai
theta0 = [zeros(1,3), deg2rad(IKinBody(B, M, Xi, zeros(5, 1), 0.0001, 0.0001))', zeros(1,4)]' % Initial Guess
Xi = updateYouBotFK(theta0)
X_errs = zeros(length(X), 6);
state = zeros(length(X), 13);
state(1, 1:12) = theta0';
for i = 1:(length(X)-1)
    [V, u, dTheta, X_errs(i, :)] = feedbackControl(Xi, configToX(X(i, :)), configToX(X(i+1, :)), kp, ki, dt, theta0);
    state(i+1, :) = [nextState(theta0, [dTheta', u'], dt, xMax), X(i, end)];
    Xi = updateYouBotFK(theta0)
    theta0 = state(i+1, 1:12)';
%     Xi = updateYouBotFK(theta0);
end

X_errs = X_errs(1:k:end, :);
configs = X(1:k:end, :);

csvwrite("finalProjectStates.csv", state)
csvwrite("finalProjectErrors.csv", X_errs)
csvwrite("finalProjectConfigs.csv", configs)