function [V, u, dThetas, X_err] = feedbackControl(T, T_d, T_di, kp, ki, dt, theta0)
% Function: Create Error Twists, Joint Velocities and Error Cals based on
% trajecotry frame i, and i+1
%
% Inputs:
% - T, T_d, T_di: (se(3)) The actual, i, and i+1 trajectories
% - kp, ki: (list[list[float]]) Diagonal matrix of gains for Porportional 
% and Integral Control
% - dt: (float) Time step in s
% - theta0: (list[floats]) Current Joint angles
%
% Outputs:
% - V: (list[float]) Error Twist
% - u: (list[float]) Wheel Velocities
% - dThetas: (list[float]) Arm Joint Velocities
% - X_err: (list[float]) Error Magnitudes

    Xm_err = T \ T_d;
    X_step = T_d \ T_di;

    X_err = se3ToVec(MatrixLog6(Xm_err));

    Vd = (1/dt) * MatrixLog6(X_step);
    Vd = se3ToVec(Vd);

    k = kp*X_err;
    p = ki*X_err*dt;

    V = Adjoint(Xm_err) * Vd + k + p;

    dThetas = pinv(youBotJb(T, theta0)) * V;

    u = dThetas(1:4);
    dThetas = dThetas(5:end);
    X_err = X_err';
end