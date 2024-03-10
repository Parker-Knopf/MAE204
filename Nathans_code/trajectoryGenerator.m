function configs = trajectoryGenerator(Tse_i, Tsc_i, Tsc_f, Tce_g, Tce_s, k)

Tse_si = Tsc_i*Tce_s; % intial standoff in s frame

Tse_g = Tsc_i*Tce_g; % grip config in s frame

Tse_sf = Tsc_f*Tce_s; % final standoff in s frame

Tse_g_f = Tsc_f*Tce_g; %final e-e pos at in final pos. cube orientation

T0 = [Tse_i, Tse_si, Tse_g, Tse_si, Tse_sf, Tse_g_f, Tse_sf]; %initial grip conditions
T1 = [T0(:,5:end) Tse_i];


grip = [0 0 1 1 1 0 0]; %final gripper state
t = [10 10 10 10 10 10 10];

n = 0;
for i = 1:length(t)
    n = n+t(i)*k/0.01;
end

configs = zeros(n,13);
for i = 1:(length(T0)/4)
    N = t(i)*k/0.01;
    
    temp = ScrewTrajectory(T0(:,4*i-3:4*i),T1(:,4*i-3:4*i),t(i),N,5);
    for j = 1:length(temp)
        mat = temp{j};
        configs(N*i-N+j,:) = [mat(1,1) mat(1,2) mat(1,3) mat(2,1) mat(2,2) mat(2,3) mat(3,1) mat(3,2) mat(3,3) mat(1,4) mat(2,4) mat(3,4) grip(i)];
    end    

end


end
