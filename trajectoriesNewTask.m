grab = 0.025;
stand = 0.15;

load("youBotConfigs.mat", "M", "B", "T_b0")
theta0 = [0 0 0 pi/6 -pi/6 pi/3 -pi/2 pi/2 0 0 0 0]';
T_0e = FKinBody(M, B, theta0(4:8));
T_se_i = makeT_sb(theta0) * T_b0 * T_0e;% initial e-e config in s frame

T_sc_i = [1 0 0 1;% initial cube configuration in s frame
          0 1 0 1;
          0 0 1 0;
          0 0 0 1];

T_sc_f = [0 1 0 1;%final cube config in s frame
          -1 0 0 -1;
          0 0 1 0;
          0 0 0 1];

alpha = pi/6;

rotY = [cos(alpha) 0 sin(alpha) 0; %rotation about y axis
        0 1 0 0;
        -sin(alpha) 0 cos(alpha) 0;
        0 0 0 1];

T_ce_g = [0 0 1 0; %grab configuratin of ee in cube frame
          0 1 0 0;
          -1 0 0 grab;
          0 0 0 1] * rotY;

T_ce_s = [0 0 1 0;%standby configuratin of ee in cube frame
          0 1 0 0;
          -1 0 0 stand;
          0 0 0 1] * rotY;