function muaArray = muaCalculation(regionProperties)

    
    [num_points,num_params] = size(regionProperties);
    
    opticalProperties = loadOpticalProperties;
    numWavelengths = length(opticalProperties);

    muaArray = zeros([num_points,numWavelengths]);

    for i = 1:num_points
        for j = 1:numWavelengths
            % if num_params == 3
            %     muaArray(i,j) = opticalProperties(j,2:3) * regionProperties(i,1:2).';
            % else
                muaArray(i,j) = opticalProperties(j,2:num_params) * regionProperties(i,1:num_params-1).';
            % end
        end
    end

end
