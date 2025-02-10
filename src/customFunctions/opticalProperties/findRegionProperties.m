function [regionProperties] = findRegionProperties(numPoints, sampling)
%ASSIGNREGIONPROPERTIES Summary of this function goes here
%   Detailed explanation goes here

    arguments
        numPoints = 3000
        sampling = 0
    end

    conc = chromophoreConcentrations;

    if sampling == 0
        [crust ,regionProperties] = generateCrustCrumbPoints(conc, numPoints, 4);
        save(['..' filesep 'output' filesep 'regionProperties_C&C'], 'regionProperties');
        save(['..' filesep 'output' filesep 'crustProperties'], 'crust');
    elseif sampling == 1
        regionProperties = generateGridlikePoints(conc, numPoints);
        save(['..' filesep 'output' filesep 'regionProperties_gridlike'], 'regionProperties');

    end

    %save(['..' filesep 'output' filesep 'regionProperties'], 'regionProperties');
    %save(['..' filesep 'output' filesep 'crustProperties'], 'crust');

    

end

