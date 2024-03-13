clear all; close all; clc;

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
x_0e = 0.033;
x_b0 = 0.1662;

z0 = 0.0963;
z1 = 0.0026;
z2 = 0.147;
z3 = 0.155;
z4 = 0.135;
z5 = 0.2176;

B5 = [0 0 1 0 0 0]';
B4 = [0 -1 0 -z5 0 0]';
B3 = [0 -1 0 -(z5+z4) 0 0]';
B2 = [0 -1 0 -(z5+z4+z3) 0 0]';
B1 = [0 0 1 0 x_0e 0]';
By = [0 0 0 0 1 0]';
Bx = [0 0 0 1 0 0]';
Bphi = [0 0 1 0 x_0e+x_b0 0]';

B = [Bphi, Bx, By, B1, B2, B3, B4, B5];

M = [1 0 0 x_0e+x_b0;
     0 1 0 0;
     0 0 1 z0+z1+z2+z3+z4+z5;
     0 0 0 1];

theta = [0, 0, 0, 0, 0, 0.2, -1.6, 0]';

%% Testing

X = FKinBody(M, B, theta);

theta0 = theta;

[V, u, theta] = feedbackControl(X, X_d, X_di, kp, ki, dt, M, B, theta0)