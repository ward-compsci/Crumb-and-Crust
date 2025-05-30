function region_lim = chromophoreConcentrations()
%CHROMOPHORECONCENTRATIONS Summary of this function goes here
%   Detailed explanation goes here

% Jacques2013


    %% Region 2 (muscle + fat)
    O2Hb_lim = [20 80] * 1e-6;
    HHb_lim = [10 70] * 1e-6;
    WF_lim = [.1 .7];
    FF_lim = [.1 .7];
    %oxCCO_lim = [.1 5] * 1e-6;
    %scatterA = [9 15] * 1e-1;
    %scatterB = [.8 3];
    % mus = musCalculation;
    mus_lim = [.4 1.5];

    melanosome_lim = [0.01 0.1];

    %%
    

    region_lim = [O2Hb_lim; HHb_lim; WF_lim; FF_lim; mus_lim].';
    %region_lim = [O2Hb_lim; HHb_lim; WF_lim; FF_lim; melanosome_lim; mus_lim].';

    writematrix(region_lim,['..' filesep 'output' filesep 'regionAll_lims']);

end

