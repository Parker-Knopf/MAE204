function configs = CellTtoConfig(data, grip)
    configs = zeros(length(data), 13);
    for i = 1:length(data)
        configs(i, :) = TtoConfig(data{i}, grip);
    end
end