clear all; close all; clc;

xDot = [pi/4 pi/4 pi/4 pi/4 pi/4 -1 1 1 -1];

tEnd = 1;
tStep = 2;
dt = tEnd/(tStep-1);
xMax = 200;

x = zeros(tStep, 13);
for i = 2:tStep
    x(i, 1:12) = nextState(x(i-1, 1:12), xDot, dt, xMax);
end

csvwrite("nextStateTestData.csv", x);