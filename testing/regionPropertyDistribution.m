function regionPropertyDistribution(regionProperties)
% REGIONPROPERTYDISTRIBUTION Plots histograms of region properties.
%   REGIONPROPERTYDISTRIBUTION(regionProperties) takes a cell array where 
%   each cell contains a matrix of region properties. Each matrix has regions 
%   as rows and different property measurements as columns. The function 
%   generates histograms for each property of each region and displays them 
%   in a tiled layout.
%
%   Input:
%   regionProperties - A cell array of matrices. Each matrix represents the 
%                      properties of regions with rows corresponding to 
%                      different regions and columns corresponding to 
%                      different properties.
%
%   Example:
%       % Define region properties for two regions
%       region1 = rand(100, 5); % 100 regions with 5 properties each
%       region2 = rand(100, 5); % 100 regions with 5 properties each
%       regionProperties = {region1, region2};
%       
%       % Plot histograms for each property of each region
%       regionPropertyDistribution(regionProperties);
%
% See also HIST, TILEDLAYOUT, NEXTTILE

    numRegions = numel(regionProperties);
    dim = size(regionProperties{1},2);

    for i = 1:numRegions
        region = regionProperties{i};
        figure;
        tiledlayout(1,5)
        for j = 1:dim
            nexttile;
            hist(region(:,j));
        end
    end

    
end

