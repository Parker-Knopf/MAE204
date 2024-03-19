function [V, u, dThetas, X_err, i] = feedbackControl(T, T_d, T_di, kp, ki, kiTotal, dt, theta0)
% Function: Create Error Twists, Joint Velocities and Error Cals based on
% trajecotry frame i, and i+1
%
% Inputs:
% - T, T_d, T_di: (se(3)) The actual, i, and i+1 trajectories
% - kp, ki: (list[list[float]]) Diagonal matrix of gains for Porportional 
% and Integral Control
% - kiTotal: (list[floats]) Total ki values from all previous time steps
% - dt: (float) Time step in s
% - theta0: (list[floats]) Current Joint angles
%
% Outputs:
% - V: (list[float]) Error Twist
% - u: (list[float]) Wheel Velocities
% - dThetas: (list[float]) Arm Joint Velocities
% - X_err: (list[float]) Error Magnitudes
% - i: Total ki after current time step

    Xm_err = T \ T_d;
    X_step = T_d \ T_di;

    X_err = se3ToVec(MatrixLog6(Xm_err));

    Vd = (1/dt) * MatrixLog6(X_step);
    Vd = se3ToVec(Vd);

    p = kp*X_err;
    i = kiTotal + ki*X_err*dt;

    V = Adjoint(Xm_err) * Vd + p + i;

    dThetas = pinv(youBotJb(T, theta0)) * V;

    u = dThetas(1:4);
    dThetas = dThetas(5:end);
    X_err = X_err';
end