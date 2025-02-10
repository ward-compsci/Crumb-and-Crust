function boundaryPoints = generateCrustPoints_2(ylims,crustPoints,rate)
%GENERATECRUSTPOINTS Summary of this function goes here
%   Detailed explanation goes here

    arguments
        ylims
        crustPoints = 3
        rate = 1
    end

    alpha = 1e4;

    yLims = ylims;
    dimensions = size(yLims,2);

    
    borderPoints = cell(1,dimensions);

    for i = 1:dimensions
        borderPoints{i} = (yLims(1,i) + (yLims(2,i)-yLims(1,i))*linspace(0,1,crustPoints).^exp(rate)).';
    end
    
    
    fullSet = cartesianProduct(borderPoints);

    alphaShapePoints = findAlphaShape(fullSet,alpha);
    
    boundaryPoints = extractBoundaryPoints(alphaShapePoints,dimensions);
    
end

