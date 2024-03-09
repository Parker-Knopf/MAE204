clear all; close all; clc;

% Nathan Cramer
% PID: A15918995
% FINAL PROJECT


%% Part 1 Kinematic Simulator (NextState)

vs = [1 1 1 1 1 -.2 .2 .2 -.2]; %test to compare w parker

t_end = 1; %second
t_steps = 100; %number of steps
dt = t_end/t_steps;
vMax = 5;

x = zeros(t_steps,13);
for i = 2:t_steps
    x(i,1:12) = nextState(x(i-1, 1:12), vs, dt, vMax);
end

csvwrite("nextStateTestData.csv", x);







