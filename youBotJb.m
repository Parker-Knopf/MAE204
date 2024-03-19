function Jb = youBotJb(X, theta0)
% Function: Create the Jacobian given current joint angles
%
% Inputs:
% - X: (se(3)) Current transfromation matrix of youBot position
% - theta0: (list[floats]) Current Joint angles
%
% Outputs:
% - Jb: (list[list[float]]) Jacobian

    load("youBotConfigs.mat", 'B', 'F', 'r', 'T_b0')

    F6 = [zeros(1,4);
        zeros(1,4);
        F.*(r/4);
        zeros(1,4)];
    
    T_sb = makeT_sb(theta0);
     
    T_0e = TransInv(T_b0) * TransInv(T_sb) * X;

    Jbase = Adjoint(TransInv(T_0e)*TransInv(T_b0))*F6;

    if size(theta0, 2) > 1
        theta0 = theta0';
    end

    Jb = [Jbase JacobianBody(B, theta0(4:8))];
end
