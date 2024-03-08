%% Forward Kinematics of KUKA youBOT

syms x y phi

% Dimensions (m)

x_b0 = 0.1662;
z_b0 = 0.0026;

x_0e = 0.033;

z1 = 0.0963;
z2 = 0.147;
z3 = 0.155;
z4 = 0.135;
z5 = 0.2176;

r = 0.0475;
l = 0.47 / 2;
w = 0.3 / 2;

T_sb = [cos(phi) -sin(phi) 0 x;
        sin(phi) cos(phi) 0 y;
        0 0 1 z1;
        0 0 0 1];

T_b0 = [1 0 0 x_b0;
        0 1 0 0;
        0 0 1 z_b0;
        0 0 0 1];

T_0e = [1 0 0 x_0e;
        0 1 0 0;
        0 0 1 z1+z2+z3+z4+z5;
        0 0 0 1];

% Screw Axis of 0e
S1 = [0 0 1 0 0 0]';
S2 = [0 -1 0 z2 0 -x_0e]';
S3 = [0 -1 0 z2+z3 0 -x_0e]';
S4 = [0 -1 0 z2+z3+z4 0 -x_0e]';
S5 = [0 0 1 0 -x_0e 0]';

S = [S1, S2, S3, S4, S5];

% Screw Axis of se
Sa = [0 0 0 1 0 0]';
Sb = [0 0 0 0 1 0]';
Sc = [0 0 1 0 0 0]';

S1 = [0 0 1 0 -x_b0 0]';
S2 = [0 -1 0 z1+z2 0 -x_b0-x_0e]';
S3 = [0 -1 0 z1+z2+z3 0 -x_b0-x_0e]';
S4 = [0 -1 0 z1+z2+z3+z4 0 -x_b0-x_0e]';
S5 = [0 0 1 0 -x_b0-x_0e 0]';

S = [Sa, Sb, Sc, S1, S2, S3, S4, S5];