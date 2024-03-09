function state1 = nextState(state0, vels, dt, vMax)

% limit max velocities
k = length(vels);
for i = 1:k
    if abs(vels(k))>vMax
        vels(i) = sign(vels(i))*vMax
    end
end

% initialize states
state1 = state0;

l = 0.74/2;
w = 0.3/2;
r = 0.0475;

u = vels(6:end)';
q = odometry(u,w,l,r);

%chasis
for i = 1:3
    state1(i) = state0(i) + q(i);
end

%arm
for i = 4:8
    state1(i) = state0(i) + vels(i)*dt;
end

%wheel angles
for i =9:12
    state1(i) = state0(i) +vels(i-3)*dt;
end

end