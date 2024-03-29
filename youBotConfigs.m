%% Parameters
x_0e = 0.033;
x_b0 = 0.1662;

z0 = 0.0963;
z1 = 0.0026;
z2 = 0.147;
z3 = 0.155;
z4 = 0.135;
z5 = 0.2176;

l = 0.47/2;
w = 0.3/2;
r = 0.0475;

%% Body Frame Screw Axes
B5 = [0 0 1 0 0 0]';
B4 = [0 -1 0 -z5 0 0]';
B3 = [0 -1 0 -(z5+z4) 0 0]';
B2 = [0 -1 0 -(z5+z4+z3) 0 0]';
B1 = [0 0 1 0 x_0e 0]';

B = [B1, B2, B3, B4, B5];


%% Zero Config EE Transformation
M = [1 0 0 x_0e;
     0 1 0 0;
     0 0 1 z2+z3+z4+z5;
     0 0 0 1];

%% YouBot Configs

F = [-1/(l + w) 1/(l + w) 1/(l + w) -1/(l + w);
     1 1 1 1;
     -1 1 -1 1];

T_b0 = [1 0 0 x_b0;
        0 1 0 0;
        0 0 1 z1;
        0 0 0 1];

save youBotConfigs.mat z0 l w r B M F T_b0
