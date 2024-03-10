clear all; close all; clc;

Tse_i = [1 0 0 0;
        0 1 0 0;
        0 0 1 1;
        0 0 0 1];

Tsc_i = [1 0 0 1;
        0 1 0 0;
        0 0 1 0.025;
        0 0 0 1];

Tsc_f = [0 1 0 0;
        -1 0 0 -1;
        0 0 1 0.025;
        0 0 0 1];
w = 3*pi/4;
% The configuration of the end-effector relative to the cube while grasping
Tce_g = [cos(w) 0 sin(w) 0;
        0 1 0 0;
        -sin(w) 0 cos(w) 0;
        0 0 0 1];

%The standoff configuration of the end-effector above the cube, before and after grasping, relative to the cube
Tce_s = [cos(w) 0 sin(w) 0;
        0 1 0 0;
        -sin(w) 0 cos(w) 0.3;
        0 0 0 1];
k=1;

configs = trajectoryGenerator(Tse_i, Tsc_i, Tsc_f, Tce_g, Tce_s, k);


csvwrite("RefTrajGenTest.csv", configs);



