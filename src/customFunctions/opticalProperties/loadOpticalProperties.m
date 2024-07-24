function newTab = loadOpticalProperties()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%   Wavelengths, O2Hb, HHb, Water, Fat, oxCCO
%   [Real Numbers, extinction coefficient, extinction coefficient,
%   absorption coefficent, absorption coefficient, extinction coefficient]

% 


%Tachtsidis, I., Gao, L., Leung, T. S., Kohl-Bareis, M., Cooper, C. E., & Elwell, C. E. (2010). A hybrid multi-distance phase and broadband spatially resolved spectrometer and algorithm for resolving absolute concentrations of chromophores in the near-infrared light spectrum. Advances in Experimental Medicine and Biology, 662, 169–175. https://doi.org/10.1007/978-1-4419-1241-1_24

    
    tab = readtable('extinctionCoeffsBale.xlsx');
    
    fatValues = readtable('fat.txt');

    newTab = ones(121,6);

    newTab(:,1) = tab{136:256,1};
    newTab(:,2) = tab{136:256,3} ./ 10;%O2Hb
    newTab(:,3) = tab{136:256,4} ./ 10;%HHb
    newTab(:,4) = waterMua(tab{136:256,2});%mua_water
    newTab(:,5) = fatValues{352:472,2};%Fat https://omlc.org/spectra/fat/fat.txt
    newTab(:,6) = tab{136:256,5} ./ 10;%oxCCO

  

end

