function T = T_sb(theta)
    load("youBotConfigs.mat", 'z0')
    
    T = [cos(theta(1)) -sin(theta(1)) 0 theta(2);
                sin(theta(1)) cos(theta(1)) 0 theta(3);
                0 0 1 z0;
                0 0 0 1];
end