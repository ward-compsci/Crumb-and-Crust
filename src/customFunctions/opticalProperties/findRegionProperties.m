function [regionProperties,crust] = findRegionProperties(numPoints)
%ASSIGNREGIONPROPERTIES Summary of this function goes here
%   Detailed explanation goes here

    arguments
        numPoints = 100
    end

    conc = chromophoreConcentrations;

    [crust ,regionProperties] = generateCrustCrumbPoints(conc, numPoints);

    save(['..' filesep 'output' filesep 'regionProperties', 'regionProperties']);
    save(['..' filesep 'output' filesep 'crustProperties', 'crust']);

    

end

