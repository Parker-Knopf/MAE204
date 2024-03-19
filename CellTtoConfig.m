function configs = CellTtoConfig(data, grip)
% Function: 
% - Convert Config Cell List to Config List
%
% Inputs:
% - data: (list[cell]) Array of configurations
% - grip: (list[floats]) List of binary gripper states
%
% Outputs
% configs: (list[list[floats]]) List of Configurations

    configs = zeros(length(data), 13);
    for i = 1:length(data)
        configs(i, :) = TtoConfig(data{i}, grip);
    end
end
