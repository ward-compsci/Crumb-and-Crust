function samplingTable = samplingTest(varargin)
%SAMPLINGTEST Summary of this function goes here
%   Detailed explanation goes here

    temp = varargin{1};
    names = fieldnames(temp);
    pointsLen = length(names);
    cycles = temp.(names{1}).cycles;

   
    sz = [4*4*cycles*2 3];
    varTypes = ["string","double","double"];
    varNames = ["Sampling","Points","Interp_Error"];
    samplingTable = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

    samplingDesigns = categorical({'Grid-like', 'Gradient', 'Random', 'Crust Crumb'});
    points = [3, 4, 5, 6];

    idx = 1;

    for i = 1:length(varargin) % Dataset (2D / 3D) - 2
        for j = 1:4 % Points per axis (3 / 4 / 5 / 6) - 4
            temp = varargin{i}.(names{j}).err(:,2,:,:); % Just RBF interp
            temp = mean(temp,1);
            temp = squeeze(temp).';
            for k = 1:4 % Sampling design - 4
                for l = 1:cycles % Cycle
                    samplingTable(idx,:) = {samplingDesigns(k),points(j),temp(l,k)};
                    idx = idx + 1;
                end
            end

        end
    end
    
    factors = samplingTable{:,1};

   
    lme = fitlme(samplingTable,'Interp_Error ~ Sampling + (1|Points)')

    aov = anova(lme)
%{
    temp = multcompare(aov)
    
    points3 = samplingTable(samplingTable{:,2} == 3, :);
    points3_ANOVA = anova(points3{:,1}, points3{:,3}, "FactorNames", "Interp");
    mc_points3 = multcompare(points3_ANOVA)

    points6 = samplingTable(samplingTable{:,2} == 6, :);
    points6_ANOVA = anova(points6{:,1}, points6{:,3}, "FactorNames", "Interp");
    mc_points6 = multcompare(points6_ANOVA)
    
%}
end

