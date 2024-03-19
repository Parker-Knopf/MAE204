clear all; close all; clc;

%% Parameters
load("youBotConfigs.mat") % Static Variables related to youBot

xMax = 50; % Max Joint Vel's

%% Task

%%% User input here %%%
task = "newTask"; % Task State
onTraj = false; % True: Start on Trajectory, False: Start off Trajectory
%%% User input here %%%

if strcmp(task, "noControl")
    kp = zeros(6);
    ki = zeros(6);

    trajectories

elseif strcmp(task, "best")
    kp = eye(6).*2;
    ki = eye(6).*0;
    
    trajectories

elseif strcmp(task, "overshoot")
    kp = eye(6).*2;
    ki = eye(6).*100;
    
    trajectories

elseif strcmp(task, "newTask")
    kp = eye(6).*2;
    ki = eye(6).*0;
    
    trajectoriesNewTask
    if (~onTraj)
        % Define New Starting Location
        theta0 = [0 0 0 pi/6 -pi/6 pi/3 -pi/2 pi/2 0 0 0 0]';
    end

else
    kp = zeros(6);
    ki = zeros(6);
    
    trajectories
end

%% Starting Location

if (onTraj)
    T_se_0 = T_se_i;
else
    if (~strcmp(task, "newTask"))
        % Define Starting Location
        theta0 = [0 0 0 pi/3 -pi/3 pi/2 -pi/3 0 0 0 0 0]';
    end
    T_0e = FKinBody(M, B, theta0(4:8));
    T_se_0 = makeT_sb(theta0) * T_b0 * T_0e;
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