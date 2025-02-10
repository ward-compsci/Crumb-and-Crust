function yRandom = generateRandomPoints_validation(npoints,ylims,dimensions)
%UNTITLED Generate a sample of points as per Crumb/Crust
%   Detailed explanation goes here

    arguments
        npoints = 5
        ylims = [0.01 1]
        dimensions = 1
    end    
    
    nPoints = npoints;
    yLims = ylims;

    axis = yLims(1) + (yLims(2)-yLims(1))*rand(nPoints^dimensions,dimensions);

    yRandom = axis;
    

end


