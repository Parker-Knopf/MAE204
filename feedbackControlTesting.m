clear all; close all; clc;
youBotConfigs

X_d = [0 0 1 0.5;
       0 1 0 0;
       -1 0 0 0.5;
        0 0 0 1];

X_di = [0 0 1 0.6;
        0 1 0 0;
        -1 0 0 0.3;
        0 0 0 1];

kp = zeros(6);

ki = zeros(6);

dt = 0.01;

%% FK
theta = [0, 0, 0, 0, 0, 0.2, -1.6, 0]';

phi = theta(1);
x = theta(2);
y = theta(3);

F6 = [zeros(1,4);
    zeros(1,4);
    F.*(r/4);
    zeros(1,4)];

T_sb = [cos(phi) -sin(phi) 0 x;
        sin(phi) cos(phi) 0 y;
        0 0 1 z0;
        0 0 0 1];

X_0e = FKinBody(M, B, theta(4:8));

X_se = T_sb * T_b0 * X_0e

%% Testing

[V, u, theta, X_err] = feedbackControl(X_se, X_d, X_di, kp, ki, dt, theta)
