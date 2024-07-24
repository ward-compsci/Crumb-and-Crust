function region_lim = chromophoreConcentrations()
%CHROMOPHORECONCENTRATIONS Summary of this function goes here
%   Detailed explanation goes here

% Jacques2013


    %% Region 2 (muscle + fat)
    O2Hb_lim = [20 80] * 1e-6;
    HHb_lim = [10 70] * 1e-6;
    WF_lim = [.1 .8];
    FF_lim = [.1 .8];
    %oxCCO_lim = [.1 5] * 1e-6;
    %scatterA = [9 15] * 1e-1;
    %scatterB = [.8 3];
    mus_lim = [55 65]*1e-1;

    %region_lim = [O2Hb_lim; HHb_lim; WF_lim; FF_lim; oxCCO_lim; scatterA; scatterB].';

    %baselineMua = [.001 .1];

    %%
    
    %region_lim = [region_lim baselineMua];

    %region_lim = [baselineMua; O2Hb_lim; HHb_lim; WF_lim; FF_lim; mus_lim].';
    region_lim = [O2Hb_lim; HHb_lim; WF_lim; FF_lim; mus_lim].';

    writematrix(region_lim,['..' filesep 'output' filesep 'regionAll_lims']);

end

