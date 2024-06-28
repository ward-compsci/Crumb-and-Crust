function mus = musCalculation()
    
    opticalProperties = loadOpticalProperties;
    
    wavelengths = opticalProperties(:,1);
    numWavelengths = length(opticalProperties);
    
    
    a = 0.5;
    b = 1;
    
    mus = zeros(length(wavelengths),1);
    for i = 1:length(wavelengths)
        mus(i) = a * (wavelengths(i) * 1e-3)^(-b);
    end

end