restoredefaultpath;
cd(fileparts(mfilename('fullpath')));
addpath(genpath(".."));

clear all
close all
clc



%%
rng(13);
cycles = 50;
samplingPoints = 3:1:6;
pert = .1;
yLims = [1, 100];
method = 'rel';
test_points = 200;

for points = samplingPoints
   multi2D_all.(['points' int2str(points)]) = comparison(yLims,points,2,pert,method,cycles,test_points);
   multi3D_all.(['points' int2str(points)]) = comparison(yLims,points,3,pert,method,cycles,test_points);
end

samplingTable = statisticalTests(multi2D_all,multi3D_all);


rbf_results = plotVaryingPoints(samplingTable);


for points = samplingPoints
    multi2D_rbf.(['points' int2str(points)]) = comparison_rbf(yLims,points,2,pert,method,cycles,test_points);
    multi3D_rbf.(['points' int2str(points)]) = comparison_rbf(yLims,points,3,pert,method,cycles,test_points);
    multi4D_rbf.(['points' int2str(points)]) = comparison_rbf(yLims,points,4,pert,method,cycles,test_points);
end

samplingTable_rbf = statisticalTests_rbf(multi2D_rbf,multi3D_rbf,multi4D_rbf);


%% Modifying bubble
clear all
close all

rng(13);
cycles = 50;
pert = .1;
yLims = [1, 100];
method = 'rel';
test_points = 200;

bubbles = 0.0001:0.005:0.1;

i = 1;
for i = 1:length(bubbles)
    bubble = bubbles(i);
    cc_2D_rbf_3Points.(['bubble' int2str(i)]) = comparison_rbf_cc(yLims,3,2,pert,method,cycles,test_points,bubble);
    cc_2D_rbf_5Points.(['bubble' int2str(i)]) = comparison_rbf_cc(yLims,4,2,pert,method,cycles,test_points,bubble);
    cc_2D_rbf_7Points.(['bubble' int2str(i)]) = comparison_rbf_cc(yLims,7,2,pert,method,cycles,test_points,bubble);
    cc_2D_rbf_9Points.(['bubble' int2str(i)]) = comparison_rbf_cc(yLims,9,2,pert,method,cycles,test_points,bubble);
end

allResults = {
    cc_2D_rbf_3Points,
    cc_2D_rbf_5Points,
    cc_2D_rbf_7Points,
    cc_2D_rbf_9Points
};
pointCounts = [3, 5, 7, 9];

plotBubble(allResults, bubbles, pointCounts);


%% Modifying perturbation
clear all
close all

rng(13);
cycles = 50;
samplingPoints = 6;
yLims = [1, 100];
method = 'rel';
test_points = 200;

perts = 0.01:1:10;
for i = 1:length(perts)
    pert = perts(i);
    rbf_2D_3Points.(['error' int2str(i)]) = comparison_rbf(yLims,3,2,pert,method,cycles,test_points);
    rbf_2D_5Points.(['error' int2str(i)]) = comparison_rbf(yLims,5,2,pert,method,cycles,test_points);
    rbf_2D_7Points.(['error' int2str(i)]) = comparison_rbf(yLims,7,2,pert,method,cycles,test_points);
    rbf_2D_9Points.(['error' int2str(i)]) = comparison_rbf(yLims,9,2,pert,method,cycles,test_points);
end

allResults = {
    rbf_2D_3Points,
    rbf_2D_5Points,
    rbf_2D_7Points,
    rbf_2D_9Points
};

pointCounts = [3, 5, 7, 9];

plotPerturbation(allResults, perts, pointCounts);

%% Increasing Crumb points
clear all
close all

rng(13);
cycles = 50;
samplingPoints = 6;
yLims = [1, 100];
method = 'rel';
test_points = 200;
pert = 0.1;
bubble = 0.01;

crumbs = 1:5:120;

for i = 1:length(crumbs)
    crumb = crumbs(i);
    rbf_2D_3Points.(['crumb' int2str(i)]) = comparison_rbf_cc(yLims,3,2,pert,method,cycles,test_points,bubble,8+crumb);
    rbf_2D_5Points.(['crumb' int2str(i)]) = comparison_rbf_cc(yLims,5,2,pert,method,cycles,test_points,bubble,16+crumb);
    rbf_2D_7Points.(['crumb' int2str(i)]) = comparison_rbf_cc(yLims,7,2,pert,method,cycles,test_points,bubble,24+crumb);
    rbf_2D_9Points.(['crumb' int2str(i)]) = comparison_rbf_cc(yLims,9,2,pert,method,cycles,test_points,bubble,32+crumb);
end

allResults = {
    rbf_2D_3Points,
    rbf_2D_5Points,
    rbf_2D_7Points,
    rbf_2D_9Points
};

pointCounts = [3, 5, 7, 9];


plotBubble(allResults, crumbs, pointCounts)

%%
clear all
close all

rng(13);
cycles = 50;
samplingPoints = 20;
yLims = [1, 100];
method = 'rel';
test_points = 200;
pert = 0.1;
bubble = 0.01;

subsampled_percents = 0.1:0.1:1;

for i = 1:length(subsampled_percents)
    subsample = subsampled_percents(i);
    rbf_2D_3Points.(['subsampled' int2str(i)]) = comparison_rbf_subsampling(yLims,5,2,pert,method,cycles,test_points,subsample);
    rbf_2D_5Points.(['subsampled' int2str(i)]) = comparison_rbf_subsampling(yLims,5,2,pert,method,cycles,test_points,subsample);
    rbf_2D_7Points.(['subsampled' int2str(i)]) = comparison_rbf_subsampling(yLims,5,2,pert,method,cycles,test_points,subsample);
    rbf_2D_9Points.(['subsampled' int2str(i)]) = comparison_rbf_subsampling(yLims,15,2,pert,method,cycles,test_points,subsample);
end

allResults = {
    rbf_2D_3Points,
    rbf_2D_5Points,
    rbf_2D_7Points,
    rbf_2D_9Points
};

pointCounts = [3, 5, 7, 9];

%plotPerturbation(allResults, subsampled_percents, pointCounts);

%plotPerturbation(rbf_2D_9Points, subsampled_percents, 9);

plotsubsampling(rbf_2D_9Points, subsampled_percents)