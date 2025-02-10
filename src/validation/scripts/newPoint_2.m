function point = newPoint_2(ylims,rate)
%NEWPOINT Summary of this function goes here
%   Detailed explanation goes here

    arguments
        ylims
        rate = 1
    end

    yLims = ylims;

    dimensions = size(yLims,2);

    point = ones(1,dimensions);

    for i = 1:dimensions
        point(i) = (yLims(1,i) + (yLims(2,i)-yLims(1,i))*rand(1).^exp(rate));
    end

end

