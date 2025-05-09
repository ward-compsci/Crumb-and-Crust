function yCrustCrumb = generateCrustCrumbPoints_validation_2(npoints,ylims,dimensions,rate,bubble,totalPoints)
%UNTITLED Generate a sample of points as per Crumb/Crust
%   Detailed explanation goes here

    arguments
        npoints = 10
        ylims = [0.01 1]
        dimensions = 2
        rate = 2
        bubble = 0.05
        totalPoints = npoints^dimensions;
    end    

    nPoints = npoints;
    yLims = repmat(ylims,dimensions,1).';

    crust = generateCrustPoints_2(yLims, nPoints,rate);
    sampledPoints = crust;

    %disp(length(sampledPoints));
    
    minAllowableDistance = (yLims(2,:) - yLims(1,:)) * bubble;
    
    while length(sampledPoints) < totalPoints
        point = newPoint_2(yLims,rate);
        distances = sqrt(sum((sampledPoints - point).^2, 2));
        
        if min(distances) >= minAllowableDistance
            sampledPoints = [sampledPoints; point];
        end
    end

    yCrustCrumb = sampledPoints;
        

end

