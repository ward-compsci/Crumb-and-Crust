function [crust,crustCrumbPoints] = generateCrustCrumbPoints(ylims,crumbPoints,crustPoints,bubble,rate)
%UNTITLED Generate a sample of points as per Crumb/Crust
%   Detailed explanation goes here

    arguments
        ylims
        crumbPoints
        crustPoints = 3
        bubble = .01
        rate = 1
    end    

    yLims = ylims;

    crust = generateCrustPoints(yLims, crustPoints);
    
    sampledPoints = crust;

    totalPoints = size(crust,1) + crumbPoints;
    
    minAllowableDistance = (yLims(2,:) - yLims(1,:)) * bubble;

    while length(sampledPoints) < totalPoints
        point = newPoint(yLims);
        %distances = sqrt((point(1) - sampledPoints(:,1).^2 + (point(2) - sampledPoints(:,2)).^2 + (point(3) - sampledPoints(:,3)).^2 + ...
        %    (point(4) - sampledPoints(:,4)).^2 + (point(5) - sampledPoints(:,5)).^2));
        distances = sqrt(sum((sampledPoints - point).^2, 2));
        
        if min(distances) >= minAllowableDistance
            sampledPoints = [sampledPoints; point];
        end
    end

    crustCrumbPoints = sampledPoints;

end


