function yBrute = generateBruteForcePoints_validation(npoints,ylims,dimensions)
%UNTITLED Generate a sample of points as per Crumb/Crust
%   Detailed explanation goes here

    arguments
        npoints = 10
        ylims = [0.01 1]
        dimensions = 1
    end    


    nPoints = npoints;
    yLims = ylims;
    %{
    axis = zeros(samplingPoints,dimensions);
    for i = 1:dimensions
        axis(:,i) = linspace(bounds(i,1),bounds(i,2),samplingPoints);
    end
    %}
    %totalPoints = cartesian_product(axis);
    %totalPoints = table2array(totalPoints);

    yBrute = linspace(yLims(1),yLims(2),nPoints);


    if dimensions == 1
        yBrute = yBrute;
    elseif dimensions == 2
        yBrute = cartesian(yBrute,yBrute);
    elseif dimensions == 3
        yBrute = cartesian(yBrute,yBrute,yBrute);
    elseif dimensions == 4
        yBrute = cartesian(yBrute,yBrute,yBrute,yBrute);
    else
        disp('Input dimensions not supported')
    end

end

