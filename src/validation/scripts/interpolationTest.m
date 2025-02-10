function means = interpolationTest(varargin)
%STATSTESTS Summary of this function goes here
%   Detailed explanation goes here
    
    temp = varargin{1};
    names = fieldnames(temp);
    pointsLen = length(names);
    cycles = temp.(names{1}).cycles;

    %means = zeros([pointsLen * 4 * cycles * length(varargin), 3]);
    means = struct;
    means.linear = [];
    means.rbf = [];
    means.natural = [];
    interpNames = ["linear", "rbf", "natural"];close
    
    for i = 1:length(varargin)
        for j = 1:length(names)
            for k = 1:3
                temp = varargin{i}.(names{j}).err(:,k,:,:);
                temp = mean(temp,1);
                temp = squeeze(temp);
                temp = reshape(temp,[numel(temp),1]);
                means.(interpNames{k}) = vertcat(means.(interpNames{k}),temp);
            end
        end
    end

    combinedMeans = [means.linear,means.rbf,means.natural];
    means = combinedMeans;

    len = length(means);
    
    factors = [repmat("Linear",len,1); repmat("RBF",len,1); repmat("Natural",len,1)];

    aov = anova(factors,means(:),"FactorNames","Interp")

    %figure
    %plotComparisons(aov);

    m = multcompare(aov,ControlGroup=2)
    %[p,t,stats] = anova(factors,means(:),"FactorNames","Interp");
    %[c,m,h,gnames] = multcompare(stats)

    %figure
    %boxchart(aov);


end

