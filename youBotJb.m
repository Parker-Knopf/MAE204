function Jb = youBotJb(X, M, B, theta0)

    eomg = 0.0001;
    ev = 0.0001;

    if size(theta0, 2) > 1
        theta0 = theta0';
    end

    [theta, null] = IKinBody(B, M, X, theta0, eomg, ev);
    Jb = JacobianBody(B, theta);
end