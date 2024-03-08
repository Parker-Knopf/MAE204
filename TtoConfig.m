function config = TtoConfig(T, grip)
    config = [T(1,1:3), T(2,1:3), T(3, 1:3), T(1:3, 4)', grip];
end