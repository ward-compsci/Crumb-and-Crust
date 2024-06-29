function muaArray = muaCalculation(regionProperties)

    
    [numPoints,~] = size(regionProperties);
    
    opticalProperties = loadOpticalProperties;
    numWavelengths = length(opticalProperties);

    muaArray = zeros([numPoints,numWavelengths]);

    for i = 1:numPoints
        for j = 1:numWavelengths
            muaArray(i,j) = opticalProperties(j,2:end-1) * regionProperties(i,2:end-1).';
            muaArray(i,j) = muaArray(i,j) + regionProperties(i,1) * 1e3;
        end
    end

end
