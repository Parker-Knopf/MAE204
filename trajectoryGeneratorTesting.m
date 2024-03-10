clear all; close all; clc;

grab = 0.025;
stand = 0.1;

T_se_i = [1 0 0 0;
          0 1 0 0;
          0 0 1 1;
          0 0 0 1];

T_sc_i = [1 0 0 1;
          0 1 0 0;
          0 0 1 0;
          0 0 0 1];

T_sc_f = [0 1 0 0;
          -1 0 0 -1;
          0 0 1 0;
          0 0 0 1];

T_ce_g = [0 0 1 0;
          0 1 0 0;
          -1 0 0 grab;
          0 0 0 1];

T_ce_s = [0 0 1 0;
          0 1 0 0;
          -1 0 0 stand;
          0 0 0 1];
k = 3;

configs = trajectoryGenerator(T_se_i, T_sc_i, T_sc_f, T_ce_g, T_ce_s, k);

csvwrite("trajectoryGeneratorTestData.csv", configs);