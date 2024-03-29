clear all; close all; clc;

%% Parameters
load("youBotConfigs.mat") % Static Variables related to youBot

xMax = 50; % Max Joint Vel's

%% Task

%%% User input here %%%
task = "overshoot"; % Task State
onTraj = false; % True: Start on Trajectory, False: Start off Trajectory
%%% User input here %%%

if strcmp(task, "noControl") %no control for testing feed forward. Recommend setting onTraj = true
    kp = zeros(6);
    ki = zeros(6);

    trajectories

elseif strcmp(task, "best") %best error twist with PI control and Feedforward
    kp = eye(6).*2;
    ki = eye(6).*0;
    
    trajectories

elseif strcmp(task, "overshoot") %forced overshoot to demonstrate controllers working
    kp = eye(6).*2;
    ki = eye(6).*2;
    
    trajectories

elseif strcmp(task, "newTask") %new block configuration 
    kp = eye(6).*3;
    ki = eye(6).*0;
    
    trajectoriesNewTask
    if (~onTraj)
        % Define New Starting Location
        theta0 = [0 .1 .1 pi/3 -pi/3 pi/2 -pi/3 0 0 0 0 0]';
    end

else
    kp = zeros(6);
    ki = zeros(6);
    
    trajectories
end

%% Starting Location

if (onTraj) %sets trajectory start to starting pos of robot
    T_se_0 = T_se_i;
else
    if (~strcmp(task, "newTask")) 
        % Define Starting Location
        theta0 = [0 .2 .2 pi/3 -pi/3 pi/2 -pi/3 0 0 0 0 0]';
    end
    T_0e = FKinBody(M, B, theta0(4:8));
    T_se_0 = makeT_sb(theta0) * T_b0 * T_0e;
end

%% Trajectories

t = [2.5 1 1 1 4 1 1 1 2.5]; % Trajectory Times
k = 2;
X = trajectoryGenerator(T_se_i, T_sc_i, T_sc_f, T_ce_g, T_ce_s, k, t); % generated trajectories for specific case determined above
dt = sum(t) / (length(X)-1); % Step Time

%% Simulation

% Data Variable Inits
Xi = T_se_0;
X_errs = zeros(length(X), 6);
state = zeros(length(X), 13);
state(1, 1:12) = theta0';
kiTotal = 0;
sb = true(1, 6);

% Main Simulation Loop
for i = 1:(length(X)-1)
    stepBool = false; % True: Step good (move on), False: Step bad (run one more time)
    while (~stepBool)
        [V, u, dTheta, X_errs(i, :), kiTotal] = feedbackControl(Xi, configToX(X(i, :)), configToX(X(i+1, :)), kp, ki, kiTotal, dt, sb, theta0);
        [s, sb] = nextState(theta0, [dTheta', u'], dt, xMax);
        stepBool = all(sb);
    end
    state(i+1, :) = [s, X(i, end)];
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