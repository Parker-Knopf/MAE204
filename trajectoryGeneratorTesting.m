clear all; close all; clc;

T_se_i = [1 0 0 0;
          0 1 0 0;
          0 0 1 1;
          0 0 0 1];

T_sc_i = [1 0 0 1;
          0 1 0 0;
          0 0 -1 0;
          0 0 0 1];

T_sc_f = [0 1 0 0;
          -1 0 0 -1;
          0 0 -1 0;
          0 0 0 1];

T_ce_g = [1 0 0 0;
          0 1 0 0;
          0 0 1 0.01;
          0 0 0 1];

T_ce_s = [1 0 0 0;
          0 1 0 0;
          0 0 1 0.05;
          0 0 0 1];
k = 3;

configs = trajectoryGenerator(T_se_i, T_sc_i, T_sc_f, T_ce_g, T_ce_s, k);

csvwrite("trajectoryGeneratorTestData.csv", configs);