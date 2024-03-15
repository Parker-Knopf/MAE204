function [V, u, dThetas, X_err] = feedbackControl(T, T_d, T_di, kp, ki, dt, theta0)

    Xm_err = T \ T_d;
    X_step = T_d \ T_di;

    X_err = se3ToVec(logm(Xm_err));

    Vd = (1/dt) * logm(X_step);
    Vd = se3ToVec(Vd);

    k = kp*X_err;
    p = ki*X_err*dt;

    V = Adjoint(Xm_err) * Vd + k + p;

    dThetas = pinv(youBotJb(T, theta0)) * V;

    u = dThetas(1:4);
    dThetas = dThetas(5:end);
end