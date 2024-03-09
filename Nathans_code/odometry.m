function qk_1 = odometry(u, w, l, r)
    M = [-1/(l + w) 1/(l + w) 1/(l + w) -1/(l + w);
         1 1 1 1;
         -1 1 -1 1];

    V = r/4 .* (M * u);
    w = V(1);
    vx = V(2);
    vy = V(3);
    
    if w == 0
        dq_b = [0, vx, vy]';
    else
        dq_b = [w, (vx*sin(w) + vy*(cos(w) - 1))/w, (vy*sin(w) + vx*(1 - cos(w)))/w]';
    end
    R = [1 0 0;
       0 cos(w) -sin(w);
       0 sin(w) cos(w)];
    qk_1 = R*dq_b;
end