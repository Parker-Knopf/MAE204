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

%% Testing

X = FKinBody(M, B, theta(4:8));

theta0 = theta;

[V, u, theta, X_err] = feedbackControl(X, X_d, X_di, kp, ki, dt, theta0)
