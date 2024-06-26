function boundaryPoints = generateCrustPoints(ylims,crustPoints,rate)
%GENERATECRUSTPOINTS Summary of this function goes here
%   Detailed explanation goes here

    arguments
        ylims
        crustPoints = 3
        rate = 2.7
    end

    alpha = 1e5;

    yLims = ylims;
    dimensions = size(yLims,2);

    
    borderPoints = cell(1,dimensions);

    for i = 1:dimensions
        borderPoints{i} = (yLims(2,i) + (yLims(1,i)-yLims(2,i))*linspace(0,1,crustPoints).^rate).';
    end
    
    
    %cartesianProduct = cartesian(boundaryPoints(:,1),boundaryPoints(:,2),boundaryPoints(:,3),boundaryPoints(:,4),boundaryPoints(:,5));


    fullSet = cartesianProduct(borderPoints);
    %fullSet = int16(fullSet);

    alphaShapePoints = findAlphaShape(fullSet,alpha);
    
    boundaryPoints = extractBoundaryPoints(alphaShapePoints,dimensions);
    
end

