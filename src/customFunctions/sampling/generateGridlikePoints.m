function fullSet = generateGridlikePoints(ylims,npoints)
%UNTITLED Generate a sample of points as per Crumb/Crust
%   Detailed explanation goes here

    arguments
        ylims
        npoints = 3125
    end    


    yLims = ylims;
    nPoints = npoints;

    dimensions = size(yLims, 2);

    points_per_axis = round(nthroot(nPoints,dimensions));

    borderPoints = cell(1,dimensions);

    for i = 1:dimensions
        borderPoints{i} = linspace(yLims(1,i),yLims(2,i),points_per_axis);
    end

    fullSet = cartesianProduct(borderPoints);

end
