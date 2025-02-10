function [samplingTable,aov] = nirsTest(varargin)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% err is 3D matrix (conc * sampling * points)

    temp = varargin{1};
    names = fieldnames(temp);
    pointsLen = length(names);
    cycles = temp.cycles;

     
    sz = [4*4*20 3];
    varTypes = ["string","double","double"];
    varNames = ["Sampling","Points","Mean"];
    samplingTable = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);


    samplingDesigns = {'Cubic', 'Gradient', 'Random', 'Crust Crumb'};
    points = [3, 4, 5, 6];

    idx = 1;

    for i = 1:length(varargin) % number of points
        for j = 1:4 % samplingLattices
            temp = varargin{i}.err;
            temp = mean(temp,1);
            temp = squeeze(temp);
            for k = 1:cycles
                samplingTable(idx,:) = {samplingDesigns(j),points(i),temp(j,k)};
                idx = idx+1;
            end
        end
    end

   
    lme = fitlme(samplingTable,'Mean ~ Sampling + (1|Points)')

    aov = anova(lme)
    



end

