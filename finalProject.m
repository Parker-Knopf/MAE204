clear all; close all; clc;

%% Parameters
trajectories
load("youBotConfigs.mat") % Static Variables related to youBot

control = false; % True: Use PI Control, False: Do not use PI Control
onTraj = true; % True: Start on Trajectory, False: Start off Trajectory

if (control)
    kp = eye(6).*2;
    ki = eye(6).*0;
else
    kp = zeros(6);
    ki = zeros(6);
end

xMax = 50; % Max Joint Vel's

% Define Starting Location
theta0 = [0 0 0 pi/6 -pi/6 pi/3 -pi/2 pi/2 0 0 0 0]';

%% Starting Location

if (onTraj)
    T_0e = FKinBody(M, B, theta0(4:8));
    T_se_0 = makeT_sb(theta0) * T_b0 * T_0e;
else
    T_se_0 = T_se_i;
end

%% Trajectories

t = [2.5 1 1 1 4 1 1 1 2.5]; % Trajectory Times
k = 4;
X = trajectoryGenerator(T_se_i, T_sc_i, T_sc_f, T_ce_g, T_ce_s, k, t);
dt = sum(t) / (length(X)-1); % Step Time

%% Simulation

% Data Variable Inits
Xi = T_se_0;
X_errs = zeros(length(X), 6);
state = zeros(length(X), 13);
state(1, 1:12) = theta0';

% Main Simulation Loop
for i = 1:(length(X)-1)
    [V, u, dTheta, X_errs(i, :)] = feedbackControl(Xi, configToX(X(i, :)), configToX(X(i+1, :)), kp, ki, dt, theta0);
    state(i+1, :) = [nextState(theta0, [dTheta', u'], dt, xMax), X(i, end)];
    theta0 = state(i+1, 1:12)';
    Xi = updateYouBotFK(theta0);
end

% k^th data elements
X_errs = X_errs(1:k:end, :);
configs = X(1:k:end, :);

%% Error Ploting

plotError(X_errs)

%% Data Construction

csvwrite("finalProjectStates.csv", state)
csvwrite("finalProjectErrors.csv", X_errs)
csvwrite("finalProjectConfigs.csv", configs)