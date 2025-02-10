function [mus_skin,mus_softTissue] = musCalculation()
    
    opticalProperties = loadOpticalProperties;
    
    wavelengths = opticalProperties(:,1);
    numWavelengths = length(opticalProperties);
    
    %Skin
    a_skin = 46;
    b_skin = 1.421;
    
    %SoftTissue
    a_softTissue = 18.9;
    b_softTissue = 1.286;

    
    mus_skin = zeros(length(wavelengths),1);
    for i = 1:length(wavelengths)
        mus_skin(i) = a_skin * (wavelengths(i)/ 500)^(-b_skin) * 1e-1;
    end

    mus_softTissue = zeros(length(wavelengths),1);
    for i = 1:length(wavelengths)
        mus_softTissue(i) = a_softTissue * (wavelengths(i)/ 500)^(-b_softTissue) * 1e-1;
    end

end