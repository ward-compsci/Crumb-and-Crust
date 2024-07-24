function [regionProperties,crust] = findRegionProperties(numPoints)
%ASSIGNREGIONPROPERTIES Summary of this function goes here
%   Detailed explanation goes here

    arguments
        numPoints = 1000
    end

    conc = chromophoreConcentrations;

    [crust ,regionProperties] = generateCrustCrumbPoints(conc, numPoints, 5);

    save(['..' filesep 'output' filesep 'regionProperties'], 'regionProperties');
    save(['..' filesep 'output' filesep 'crustProperties'], 'crust');

    

end

