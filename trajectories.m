grab = 0.025;
stand = 0.15;

T_se_i = [1 0 0 0;
          0 1 0 0;
          0 0 1 .7;
          0 0 0 1];

T_se_ai = [1 0 0 0;
          0 1 0 0;
          0 0 1 .7;
          0 0 0 1]; % Actual Position index0

T_sc_i = [1 0 0 1;
          0 1 0 0;
          0 0 1 0;
          0 0 0 1];

T_sc_f = [0 1 0 0;
          -1 0 0 -1;
          0 0 1 0;
          0 0 0 1];

alpha = pi/4;

rotY = [cos(alpha) 0 sin(alpha) 0;
        0 1 0 0;
        -sin(alpha) 0 cos(alpha) 0;
        0 0 0 1];

T_ce_g = [0 0 1 0;
          0 1 0 0;
          -1 0 0 grab;
          0 0 0 1] * rotY;

T_ce_s = [0 0 1 0;
          0 1 0 0;
          -1 0 0 stand;
          0 0 0 1] * rotY;