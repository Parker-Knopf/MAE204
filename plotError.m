function plotError(varargin)
% Function: Plots all Errors for given data
%
% Inputs:
% - varargin: (list[list[float]]) Data given in state protocal
%
% Outputs:
% - Figure: (Plot)

    if nargin == 1
        data = varargin{1};
    elseif nargin == 0
        data = csvread('finalProjectErrors.csv');
    else
        return
    end

    figure(1)
    hold on
    plot(data(:,1))
    plot(data(:,2))
    plot(data(:,3))
    plot(data(:,4))
    plot(data(:,5))
    plot(data(:,6))
    legend('wx' , 'wy', 'wz', 'vx', 'vy', 'vz')
    title("Trajectory Twist Errors")
    xlabel("time")
    ylabel("Twist Error Mag")

    saveas(gcf, "Error.png");
end