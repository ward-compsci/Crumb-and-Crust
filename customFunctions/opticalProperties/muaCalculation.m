function regionMua = muaCalculation(regionProperties)

    
    numRegions = numel(regionProperties);
    [numElements,dim] = size(regionProperties{1});
    
    opticalProperties = loadOpticalProperties;
    numWavelengths = length(opticalProperties);


    regionMua = cell([1 numRegions]);
    temp = zeros([numElements,numWavelengths,dim]);

    for i = 1:numRegions
        for j = 1:dim
            for k = 1:numWavelengths
                temp(:,k,j) = opticalProperties(k,j+1) * regionProperties{i}(:,j);
                mua = sum(temp,3);
            end
        end
        regionMua{i} = mua;
    end

end
