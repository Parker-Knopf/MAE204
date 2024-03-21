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

    t = linspace(0,15,length(data));

    figure(1)
    hold on
    plot(t,data(:,1))
    plot(t,data(:,2))
    plot(t,data(:,3))
    plot(t,data(:,4))
    plot(t,data(:,5))
    plot(t,data(:,6))
    legend('wx' , 'wy', 'wz', 'vx', 'vy', 'vz')
    title("Trajectory Twist Errors")
    xlabel("time (seconds)")
    ylabel("Twist Error Mag")

    saveas(gcf, "Error.png");
end