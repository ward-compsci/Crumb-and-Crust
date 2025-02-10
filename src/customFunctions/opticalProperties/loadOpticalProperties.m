function newTab = loadOpticalProperties()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%   Wavelengths, O2Hb, HHb, Water, Fat, oxCCO
%   [Real Numbers, extinction coefficient, extinction coefficient,
%   absorption coefficent, absorption coefficient, extinction coefficient]

% With scaling to mm^-1


%Tachtsidis, I., Gao, L., Leung, T. S., Kohl-Bareis, M., Cooper, C. E., & Elwell, C. E. (2010). A hybrid multi-distance phase and broadband spatially resolved spectrometer and algorithm for resolving absolute concentrations of chromophores in the near-infrared light spectrum. Advances in Experimental Medicine and Biology, 662, 169–175. https://doi.org/10.1007/978-1-4419-1241-1_24

    
    tab = readtable('extinctionCoeffsBale.xlsx');
    
    fatValues = readtable('fat.txt');

    wavelengths = 690:1:900;

    newTab = ones(length(wavelengths),6);

    newTab(:,1) = tab{46:256,1};
    newTab(:,2) = tab{46:256,3} * 1e-1;%O2Hb
    newTab(:,3) = tab{46:256,4} * 1e-1;%HHb
    newTab(:,4) = waterMua(tab{46:256,2}) * 1e-1;%mua_water
    newTab(:,5) = fatValues{262:472,2} * 1e-3;%Fat https://omlc.org/spectra/fat/fat.txt
    newTab(:,6) = melanosomeMua; %https://omlc.org/spectra/melanin/mua.html
    % newTab(:,6) = tab{136:256,5} ./ 10;%oxCCO

  

end

