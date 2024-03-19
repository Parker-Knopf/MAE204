function X = configToX(c)
% Function: Convert from state protocal to se(3)
%
% Inputs:
% - c: (list[float]) State protocal
%
% Outputs:
% - X: se(3)

    X = [c(1) c(2) c(3) c(10);
         c(4) c(5) c(6) c(11);
         c(7) c(8) c(9) c(12);
         0 0 0 1];
end