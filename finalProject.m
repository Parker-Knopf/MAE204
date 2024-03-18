clear all; close all; clc;

%% Parameters
trajectories
load("youBotConfigs.mat")

% kp = zeros(6);
% ki = zeros(6);

kp = eye(6).*2;
ki = eye(6).*0;

xMax = 50; % Change this later

%% Trajectories

t = [4 2 0.5 1 2 2 1 1 1.5];
k = 4;
dt = 0.01 / k;

% control pos, joint angles and wheel angles 
% forward kinematics
% use this FK as starting pos and start of trajectory instead of working
% backwards from a transformation matrix
theta0 = [0 0 0 pi/6 -pi/6 pi/3 -pi/2 pi/2 0 0 0 0]';
T0e = FKinBody(M,B,theta0(4:8));
T_se = T_sb * T_b0 * T0e;

t = [2.5 1 1 1 1 4 1 1 2.5];
k = 4;
X = trajectoryGenerator(T_se_i, T_sc_i, T_sc_f, T_ce_g, T_ce_s, k, t);
dt = sum(t) / (length(X)-1);

Xi = T_se;
% [theta, s] = IKinBody(B, M, SpaceToArmFrame(Xi, zeros(1,3)), [0, 1.38, -1, -.4, 0]', 0.00001, 0.00001);
% theta0 = [zeros(1,3), theta', zeros(1,4)]'; % Initial Guess
X_errs = zeros(length(X), 6);
state = zeros(length(X), 13);
state(1, 1:12) = theta0';
for i = 1:(length(X)-2)
    [V, u, dTheta, X_errs(i, :)] = feedbackControl(Xi, configToX(X(i+1, :)), configToX(X(i+2, :)), kp, ki, dt, theta0);
    state(i+1, :) = [nextState(theta0, [dTheta', u'], dt, xMax), X(i, end)];
    theta0 = state(i+1, 1:12)';
    Xi = updateYouBotFK(theta0);
end

X_errs = X_errs(1:k:end, :);
configs = X(1:k:end, :);

figure(1)
hold on
plot(X_errs(:,1))
plot(X_errs(:,2))
plot(X_errs(:,3))
plot(X_errs(:,4))
plot(X_errs(:,5))
plot(X_errs(:,6))
legend('wx' , 'wy', 'wz', 'vx', 'vy', 'vz')



csvwrite("finalProjectStates.csv", state)
csvwrite("finalProjectErrors.csv", X_errs)
csvwrite("finalProjectConfigs.csv", configs)