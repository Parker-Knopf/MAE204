function T_se = updateYouBotFK(theta0)
% Function: Update youBot configuration with FK
%
% Inputs:
% - theta0: (list[float]) Joint Angles
%
% Outputs:
% - T_se: Configuration given joint angles

    load("youBotConfigs.mat", 'B', 'M', 'T_b0')

    T_0e = FKinBody(M, B, theta0(4:8));

    T_sb = makeT_sb(theta0);

    T_se = T_sb * T_b0 * T_0e;
end