function config = TtoConfig(T, grip)
% Function: Convert from se(3) to state protocal
%
% Inputs:
% - T: (se(3)) Configuration
% - grip: (bool) Boolean value of gripper state
%
% Outputs:
% - config: (list[float]) State Protocal of joint angles

    config = [T(1,1:3), T(2,1:3), T(3, 1:3), T(1:3, 4)', grip];
end