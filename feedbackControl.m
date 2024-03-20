function [V, u, dThetas, X_err, i] = feedbackControl(T, T_d, T_di, kp, ki, kiTotal, dt, sb, theta0)
% Function: Create Error Twists, Joint Velocities and Error Cals based on
% trajecotry frame i, and i+1
%
% Inputs:
% - T, T_d, T_di: (se(3)) The actual, i, and i+1 trajectories
% - kp, ki: (list[list[float]]) Diagonal matrix of gains for Porportional 
% and Integral Control
% - kiTotal: (list[floats]) Total ki values from all previous time steps
% - dt: (float) Time step in s
% - sb: (list[logical]) List of boolean values for arm joints to keep
% movement due to joint limits being reached
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

    X_err = se3ToVec(MatrixLog6(Xm_err)); %current error twist

    Vd = (1/dt) * MatrixLog6(X_step);
    Vd = se3ToVec(Vd); 

    p = kp*X_err; %proportional gain timmes error
    i = kiTotal + ki*X_err*dt;%intergal gain accumulated ofer trajectory

    V = Adjoint(Xm_err) * Vd + p + i;

    dThetas = pinv(youBotJb(T, theta0, ~sb), 1e-4) * V; %updated arm joint velocities after calculating new jacobian

    u = dThetas(1:4);
    dThetas = dThetas(5:end);
    X_err = X_err';
end