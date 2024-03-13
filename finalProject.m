clear all; close all; clc;

%% Parameters
load("configurations.m")
load("kinematics.m")

kp = zeros(6);
ki = zeros(6);

xMax = 0;

%% Trajectories

t = [1 1 1 1 1 1 1 1];
k = 10;
dt = k / 0.01;
X = trajectoryGenerator(T_se_i, T_sc_i, T_sc_f, T_ce_g, T_ce_s, k, t);

theta0 = []';
X_errs = zeros(lengh(X), 6);
state = zeros(length(X), 12);
for i = 1:(length(X)-1)
    % IDK what X should be
    [V, u, dTheta, X_errs(:, i)] = feedbackControl(X, configToX(X(:, i)), configToX(X(:, i+1)), kp, ki, dt, M, B, theta0);
    state(i, :) = [nextState(theta0, dTheta, dt, xMax), X(i, end)];
    theta0 = [state(i, 9:1), state(i, 4:8)]';
end

kn = 0;
X_errs = X_err(:, 1:kn:end);
configs = X(1:kn:end, :);

csvwrite("finalProjectStates_PK.csv", state)
csvwrite("finalProjectErrors_PK.csv", X_errs)