clear all; close all; clc;

xDot = [1 1 1 1 1 .2 -.2 .2 -.2];

tEnd = 1;
tStep = 100;
dt = tEnd/tStep;
xMax = 2;

x = zeros(tStep, 13);
for i = 2:tStep
    x(i, 1:12) = nextState(x(i-1, 1:12), xDot, dt, xMax);
end

csvwrite("nextStateTestData.csv", x);